
output "vpc_id" {
  value       = module.networking.vpc_id
}

output "public_subnet_name" {
  value       = module.networking.public_subnet_name
}

output "private_subnet_name" {
  value       = module.networking.private_subnet_name
}

output "public_subnet_id" {
  value       = module.networking.public_subnet_id
}

output "private_subnet_id" {
  value       = module.networking.private_subnet_id
}

output "igw_name" {
  value       = module.networking.igw_name
}

output "private_instance_ip" {
  value       = module.ec2[0].private_instance_ip
}

output "pg_connection_address" {
  value = module.rds[0].pg_connection_address
}

output "aws_lb" {
  value = module.networking.aws_lb
}