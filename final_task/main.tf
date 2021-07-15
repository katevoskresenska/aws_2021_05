terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

module "networking" {
  source = "./modules/networking"
    nat_instance_id = module.ec2[0].nat_instance_id
    public_sg_id = module.ec2[0].public_sg_id
    aws_autoscaling_group_id = module.ec2[0].aws_autoscaling_group_id
}

module "ec2" {
  source = "./modules/ec2"
    vpc_id  = module.networking.vpc_id
    count   = length(module.networking.public_subnet_id)
    public_subnet_id = element(module.networking.public_subnet_id, count.index)
    private_subnet_id = element(module.networking.private_subnet_id, 0)
    pg_connection_address = module.rds[0].pg_connection_address
}

module "rds" {
  source = "./modules/rds"
      count   = length(module.networking.private_subnet_id)
      private_subnet_id = element(module.networking.private_subnet_id, count.index)
      vpc_id  = module.networking.vpc_id
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "sns_sqs" {
  source = "./modules/sns_sqs"
}