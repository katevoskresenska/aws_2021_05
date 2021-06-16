output "pg_connection_endpoint" {
  description = "Endpoint for PG database connection"
  value       = aws_db_instance.default.endpoint
}

output "pg_connection_port" {
  description = "Port for PG database connection"
  value       = aws_db_instance.default.port
}