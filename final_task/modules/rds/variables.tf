variable "pg_db_identifier" {
  type        = string
  default     = "terraform-postgres"
}

variable "pg_db_allocated_storage" {
  type        = number
  default     = 10
}

variable "pg_db_engine" {
  type        = string
  default     = "postgres"
}

variable "pg_db_engine_version" {
  type        = string
  default     = "12.5"
}

variable "pg_db_instance_class" {
  type        = string
  default     = "db.t2.micro"
}

variable "pg_db_name" {
  type        = string
  default     = "EduLohikaTrainingAwsRds"
}

variable "pg_db_username" {
  type        = string
  default     = "rootuser"
}

variable "pg_db_pwd" {
  type        = string
  default     = "rootuser"
}

variable "pg_db_parameter_group_name" {
  type        = string
  default     = "default.postgres12"
}

variable "pg_db_skip_final_snapshot" {
  type        = bool
  default     = true
}

variable "iam_database_authentication_enabled" {
  type        = bool
  default     = true
}

variable "pg_ingress_port" {
  type        = number
  description = "ingress port"
  default     = 5432
}

variable "pg_sg_cidr_blocks" {
  description = "cidr_block for security group"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.4.0/24"]
}

variable "private_subnet_id" {}

variable "vpc_id" {}
