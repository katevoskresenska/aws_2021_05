variable "instanse_ami" {
  description = "Value of the ami for the EC2 instance"
  type        = string
  default     = "ami-03d5c68bab01f3496"
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
# variable "private_ingress_ports" {
#   type        = list(number)
#   description = "list of ingress ports"
#   default     = [22, 80, -1]
# }

variable "private_sg_cidr_block" {
  description = "cidr_block for security group"
  type        = string
  default     = "10.0.1.0/24"
}

variable "key_path" {
  description = "ssh key localpath"
  type        = string
  default = "~/.ssh/aws_lohika.pem"
}

variable "vpc_id" {}

variable "subnet_id" {}

variable "environment" {
  type        = string
  default     = "development"
}