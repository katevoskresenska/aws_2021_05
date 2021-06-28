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
  default     = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "public_availability_zones" {
  type        = list(string)
  default     = ["us-west-2a"]
}

variable "private_availability_zones" {
  type        = list(string)
  default     = ["us-west-2b"]
}

variable "instance_id" {}