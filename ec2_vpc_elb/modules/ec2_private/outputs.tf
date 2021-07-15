output "private_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.private_instance.id
}

output "private_instance_ip" {
  description = "IP address of the EC2 instance"
  value       = aws_instance.private_instance.private_ip
}