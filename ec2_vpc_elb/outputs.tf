output "vpc_id" {
  value       = module.networking.vpc_id
}

output "public_subnet_name" {
  value       = module.networking.public_subnet_name
}

output "private_subnet_name" {
  value       = module.networking.private_subnet_name
}

output "igw_name" {
  value       = module.networking.igw_name
}

output "public_subnet_id" {
  value       = module.networking.public_subnet_id
}

output "private_subnet_id" {
  value       = module.networking.private_subnet_id
}

output "webserver_id" {
  value       = module.ec2[0].webserver_id
}

output "webserver_public_ip" {
  value       = module.ec2[0].webserver_public_ip
}

output "private_instance_ip" {
  value       = module.ec2_private[0].private_instance_ip
}

output "instance_id" {
  value       = module.ec2[0].instance_id
}