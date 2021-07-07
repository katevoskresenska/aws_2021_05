resource "aws_sqs_queue" "edu-lohika-training-aws-sqs-queue" {
  name                        = "edu-lohika-training-aws-sqs-queue"

  tags = {
    Name        = "${var.environment}-sqs-queue"
    Environment = var.environment
  }
}

resource "aws_sns_topic" "edu-lohika-training-aws-sns-topic" {
  name                        = "edu-lohika-training-aws-sns-topic"
}

resource "aws_sns_topic_subscription" "topic-subscription" {
  topic_arn = aws_sns_topic.edu-lohika-training-aws-sns-topic.arn
  protocol  = "email"
  endpoint  = "kate.voskresenska@gmail.com"
}