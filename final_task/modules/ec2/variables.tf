variable "instanse_ami" {
  description = "Value of the ami for the EC2 instance"
  type        = string
  default     = "ami-03d5c68bab01f3496"
}

variable "nat_instanse_ami" {
  description = "Value of the ami for the NAT EC2 instance"
  type        = string
  default     = "ami-0032ea5ae08aa27a2"
}
variable "instanse_type" {
  description = "Type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instanse_key_name" {
  description = "SSh key name for the EC2 instance"
  type        = string
  default     = "aws_lohika"
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80]
}

variable "sg_cidr_block" {
  description = "cidr_block for security group"
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_path" {
  description = "ssh key localpath"
  type        = string
  default = "~/.ssh/aws_lohika.pem"
}

variable "vpc_id" {}

variable "public_subnet_id" {}

variable "environment" {
  type        = string
  default     = "development"
}

variable "rules" {
  type = list(object({
    port = number 
    protocol = string
    }))
  default = [
      {port: 22, protocol: "tcp"},
      {port: 80, protocol: "tcp"},
      {port: -1, protocol: "icmp"}
  ]
  
}

variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_id" {}

variable "public_availability_zones" {
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "bucket_name" {
  type        = string
  default     = "iamkatyu-finaltask-bucket"
}

variable "user_data_file" {
  type        = string
  default = "./modules/ec2/user_data.sh"
}

variable "pg_connection_address" {}