output "pg_connection_endpoint" {
  description = "Endpoint for PG database connection"
  value       = aws_db_instance.default.endpoint
}

output "pg_connection_port" {
  description = "Port for PG database connection"
  value       = aws_db_instance.default.port
}

output "pg_connection_address" {
  description = "Address for PG database connection"
  value       = aws_db_instance.default.address
}
