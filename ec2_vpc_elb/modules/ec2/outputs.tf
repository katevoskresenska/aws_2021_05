output "webserver_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "webserver_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_id" {
  value       = aws_instance.nat_instance.id
}