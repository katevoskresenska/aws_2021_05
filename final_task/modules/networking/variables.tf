variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  type        = string
  default     = "development"
}

variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.4.0/24"]
}

variable "public_availability_zones" {
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "private_availability_zones" {
  type        = list(string)
  default     = ["us-west-2c", "us-west-2d"]
}

variable "nat_instance_id" {}

variable "public_sg_id" {}

variable "aws_autoscaling_group_id" {}