variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "ami_name" {
  description = "Ami name of the base image"
  type        = string
  default     = ""
}

variable "bastion_host" {
  description = "Bastion host"
  type        = string
}

variable "private_key" {
  description = "Private key"
}

variable "ssh_user" {
  description = "ssh user"
  default     = "ubuntu"
}

variable "replica_count" {
  description = "Number of nodes for replica set"
  default     = 3
}

variable "db_admin_user" {
  default     = "admin"
  description = "An adminstrative user for managing mongo dbs"
}

variable "db_admin_pwd" {
  default     = "admin"
  description = "An adminstrative user password"
}

variable "data_volumes" {
  type = list(object({
    ebs_volume_id     = string
    availability_zone = string
  }))
  description = "List of EBS volumes"
}


