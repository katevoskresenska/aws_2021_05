resource "aws_dynamodb_table" "default" {
  name           = var.dynamodb_table_name
  billing_mode   = var.dynamodb_billing_mode
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "UserName"

  attribute {
    name = "UserName"
    type = "S"
  }

  tags = {
    Name        = var.dynamodb_tag_name
    Environment = var.dynamodb_tag_env
  }
}