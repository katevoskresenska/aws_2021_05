output "queue_url" {
  description = "SQS queue url"
  value       = aws_sqs_queue.edu-lohika-training-aws-sqs-queue.url
}

output "topic_arn" {
  description = "SNS topic ARN"
  value       = aws_sns_topic.edu-lohika-training-aws-sns-topic.arn
}