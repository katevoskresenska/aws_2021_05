output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.a_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.a_server.public_ip
}

output "queue_url" {
  description = "SQS queue url"
  value       = aws_sqs_queue.queue.url
}

output "topic_arn" {
  description = "SNS topic ARN"
  value       = aws_sns_topic.topic.arn
}