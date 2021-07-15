output "nat_instance_id" {
  value       = aws_instance.nat_instance.id
}

output "public_sg_id" {
  value       = aws_security_group.public_sg.id
}

output "private_instance_ip" {
  value       = aws_instance.private_instance.private_ip
}

output "aws_autoscaling_group_id" {
  value       = aws_autoscaling_group.asg.id
}