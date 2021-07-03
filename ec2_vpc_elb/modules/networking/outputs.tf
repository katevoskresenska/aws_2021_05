output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_name" {
  value = [aws_subnet.public_subnet.*.tags.Name]
}

output "private_subnet_name" {
  value = [aws_subnet.private_subnet.*.tags.Name]
}

output "igw_name" {
  value = aws_internet_gateway.igw.tags.Name
}

output "public_subnet_id" {
  value = [aws_subnet.public_subnet.*.id]
}

output "private_subnet_id" {
  value = [aws_subnet.private_subnet.*.id]
}

output "aws_lb" {
  value = aws_lb.application_lb.dns_name
}