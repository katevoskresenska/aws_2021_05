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

module "dynamodb" {
  source    = "./modules/dynamodb"
}

module "postgresdb" {
  source    = "./modules/postgresdb"
}

module "ec2" {
  source    = "./modules/ec2"
}
