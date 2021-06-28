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

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80]
}

variable "sg_cidr_block" {
  description = "cidr_block for security group"
  type        = string
  default     = "178.165.103.138/32"
}

variable "bucket_name" {
  description = "s3 bucket name"
  type        = string
  default     = "iamkatyu-second-bucket"
}

variable "key_path" {
  description = "ssh key localpath"
  type        = string
  default = "~/.ssh/aws_lohika.pem"
}