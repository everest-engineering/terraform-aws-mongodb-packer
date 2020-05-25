data "aws_ami" "image" {
  most_recent = true
  owners      = ["self"]
  count       = var.ami == "" ? 1 : 0

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}

resource "random_string" "mongo_key" {
  length = 512
  special = false
}

data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")
  vars = {
    mongo_key = random_string.mongo_key.result
  }
}

resource "aws_instance" "mongodb" {
  count                  = var.replica_count
  ami                    = var.ami == "" ? data.aws_ami.image[count.index].id : var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  tags                   = var.tags
  user_data              = data.template_file.user_data.rendered
}

resource "aws_volume_attachment" "mongo-data-vol-attachment" {
  count       = var.replica_count
  device_name = "/dev/xvdf"
  volume_id   = var.data_volumes[count.index].ebs_volume_id
  instance_id = aws_instance.mongodb[count.index].id

  skip_destroy = true
}

resource "null_resource" "replicaset_initialization_and_users" {

  provisioner "file" {
    content = templatefile("${path.module}/templates/init-replicaset.js.tmpl", {
      ip_addrs = aws_instance.mongodb.*.private_ip
    })
    destination = "/tmp/init-replicaset.js"
  }

  provisioner "file" {
    content = templatefile("${path.module}/templates/admin.js.tmpl", {
      admin_user = var.db_admin_user
      admin_pwd  = var.db_admin_pwd
    })
    destination = "/tmp/admin.js"
  }

  provisioner "remote-exec" {
    inline = [
      "while [ ! -f /tmp/signal ]; do sleep 2; done",
      "mongo 127.0.0.1:27017/admin /tmp/init-replicaset.js",
      "sleep 30",
      "mongo 127.0.0.1:27017/admin /tmp/admin.js",
    ]
  }

  connection {
    host         = aws_instance.mongodb[0].private_ip
    type         = "ssh"
    user         = var.ssh_user
    private_key  = var.private_key
    bastion_host = var.bastion_host
    agent        = true
  }
}
