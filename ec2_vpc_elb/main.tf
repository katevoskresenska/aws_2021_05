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
    instance_id = module.ec2[0].instance_id
    webserver_id = module.ec2[0].webserver_id
    private_instance_id = module.ec2_private[0].private_instance_id
    public_sg_id = module.ec2[0].public_sg_id
}

module "ec2" {
  source    = "./modules/ec2"
    vpc_id  = module.networking.vpc_id
    count   = length(module.networking.public_subnet_id)
    subnet_id = element(module.networking.public_subnet_id, count.index)
    environment = var.environment   
}

module "ec2_private" {
  source    = "./modules/ec2_private"
    vpc_id  = module.networking.vpc_id
    count   = length(module.networking.private_subnet_id)
    subnet_id = element(module.networking.private_subnet_id, count.index)
    environment = var.environment   
}