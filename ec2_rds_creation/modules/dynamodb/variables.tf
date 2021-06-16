variable "dynamodb_table_name" {
  type        = string
  default     = "a_table"
}

variable "dynamodb_billing_mode" {
  type        = string
  default     = "PROVISIONED"
}

variable "dynamodb_tag_name" {
  type        = string
  default     = "dynamodb-table-1"
}

variable "dynamodb_tag_env" {
  type        = string
  default     = "dev"
}