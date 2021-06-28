resource "aws_dynamodb_table" "default" {
  name           = var.dynamodb_table_name
  billing_mode   = var.dynamodb_billing_mode
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Id"
  range_key      = "DateTime"

  attribute {
    name = "Id"
    type = "N"
  }

  attribute {
    name = "DateTime"
    type = "S"
  }

  tags = {
    Name        = var.dynamodb_tag_name
    Environment = var.dynamodb_tag_env
  }
}