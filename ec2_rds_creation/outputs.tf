output "pg_connection_endpoint" {
    value = "${module.postgresdb.pg_connection_endpoint}"
}

output "pg_connection_port" {
    value = "${module.postgresdb.pg_connection_port}"
}

output "dynamodb_table_id" {
  value       = "${module.dynamodb.dynamodb_table_id}"
}

output "dynamodb_table_arn" {
  value       = "${module.dynamodb.dynamodb_table_arn}"
}

output "instance_id" {
  value       = "${module.ec2.instance_id}"
}

output "instance_public_ip" {
  value       = "${module.ec2.instance_public_ip}"
}
