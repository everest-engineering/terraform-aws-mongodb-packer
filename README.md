This module is part of a project to simplify the provisioning of MongoDB on AWS cloud using Terraform. You may also wish to consider [one of the other approaches](https://github.com/everest-engineering/terraform-mongodb-provisioning).

# Terraform module to provision MongoDB using Packer

A terraform module to launch the single tier mongo instance on `AWS`.

These types of resources are supported:
`EC2 instance`

![MongoDB on Packer EC2 Instances](images/Mongo-Packer.png)

### Tech

- [Terraform] - Terraform enables you to safely and predictably create, change, and improve infrastructure. It is an open source tool that codifies APIs into declarative .

### Installation

Install terraform using below documentation

`https://learn.hashicorp.com/terraform/getting-started/install.html`

### Dependencies

Before you start using this module, you need create your own mongodb AMI modules.
`ami id of custom mongodb image`

### To build Mongodb AMI:

You can start building your images using this [packer-repo](`https://github.com/everest-engineering/terraform-mongodb-provisioning-packer/tree/master/packer`). You can pass the created AMI id to the this module.

### Module usage

```sh
module "terraform-mongodb" {
  source = "git@github.com:everest-engineering/terraform-mongodb-provisioning-packer.git"
  ami = "ami-0091d303b9f45e661"
  instance_type = "t2.micro"
  subnet_id = "subnet-eddcdzz4"
  vpc_security_group_ids=["sg-12345678"]
  key_name="deployer-key1"
  platform="ubuntu-18.04"
  mongodb_version="4.2"
  ami_version="1.0"
  tags = {
    Name = "New packer mongo"
  }
}
```

### Examples

[Terraform-mongodb-example](examples)

### Inputs

| Name                        | Description                                             | Type   | Default      | Required |
| --------------------------- | ------------------------------------------------------- | ------ | ------------ | -------- |
| ami                         | ID of AMI to use for the instance                       | string | n/a          | yes      |
| instance_count              | Number of instances to launch                           | number | "1"          | no       |
| instance_type               | The type of instance to start                           | string | n/a          | yes      |
| subnet_id                   | The VPC Subnet ID to launch in                          | string | ""           | no       |
| vpc_security_group_ids      | A list of security group IDs to associate with          | list   | "null"       | no       |
| key_name                    | The key name to use for the instance                    | string | ""           | no       |
| tags                        | A mapping of tags to assign to the resource             | list   | {}           | no       |
| platform                    | Name of the Base vanilla image os                       | string | ubuntu-18.04 | no       |
| mongodb_version             | Mongodb version                                         | string | 4.2          | no       |
| ami_version                 | Version of ami                                          | string | v1.0         | no       |
| replica_count               | Number of nodes for replica set                         | number | 3            | no       |
| db_admin_user               | Administrative user for managing mongo db               | string | "admin"      | no       |
| db_admin_pwd                | Administrative user password                            | string | "admin"      | no       |
| private_key                 | A private key file to provision instances               | string | ""           | yes      |

### Outputs

| Name                                 | Description                                                           |
| ------------------------------------ | --------------------------------------------------------------------  |
| instance_id_list                     | List of IDs of instances                                              |
| instance_arn_list                    | List of ARNs of instances                                             |
| instance_key_name_list               | List of key names of instances                                        |
| instance_private_ip_list             | List of private IP addresses assigned to the instances, if applicable |
| instance_security_group_list         | List of associated security groups of instances                       |
| instance_vpc_security_group_id_list  | List of associated security groups of instances                       |
| instance_subnet_id_list              | List of IDs of VPC subnets of instances                               |
| instance_tags_list                   | List of tags of instances                                             |
| instance_state_list                  | List of instance states of instances                                  |

## Testing

1. Install Go https://golang.org/doc/install
2. Configure AWS Credentials as environment variables as mentioned above.

```shell script
> cd test
> go test -v
```

## Contributing

We appreciate your help!

[Open an issue](https://github.com/everest-engineering/terraform-mongodb-provisioning-packer/issues/new) or submit a pull request for an enhancement.
Browse through the
[current open issues](https://github.com/everest-engineering/terraform-mongodb-provisioning-packer/issues).

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Authors

> Talk to us `hi@everest.engineering`.

[![License: EverestEngineering](https://img.shields.io/badge/Copyright%20%C2%A9-EVERESTENGINEERING-blue)](https://everest.engineering)
