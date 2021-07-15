output "dynamodb_table_id" {
  description = "ID of Dynamodb table"
  value       = aws_dynamodb_table.default.id
}

output "dynamodb_table_arn" {
  description = "AWS Resource Name of dynamodb_table"
  value       = aws_dynamodb_table.default.arn
}