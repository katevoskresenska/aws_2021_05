terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Ingress for ssh"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_cidr_block]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.environment}-ssh-sg"
    Environment = var.environment
  }

}


resource "aws_iam_role" "sns_sqs_iam_role" {
    name = "sns_sqs_iam_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_instance_profile" "sns_sqs_instance_profile" {
    name = "sns_sqs_instance_profile"
    role = "sns_sqs_iam_role"
}

resource "aws_iam_role_policy" "sns_sqs_iam_role_policy" {
  name = "sns_sqs_iam_role_policy"
  role = aws_iam_role.sns_sqs_iam_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["sns:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["sqs:*"],
      "Resource": ["*"]
    }
  ]
}
EOF
}


resource "aws_instance" "a_server" {
  ami                    = var.instanse_ami
  instance_type          = var.instanse_type
  key_name               = var.instanse_key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  iam_instance_profile = aws_iam_instance_profile.sns_sqs_instance_profile.id

  tags = {
    Name        = "${var.environment}-sqs-sns-ec2"
    Environment = var.environment
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y awscli",
    ]
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    password = ""
    private_key = file(var.key_path)
    host     = self.public_ip
  }
}

resource "aws_sqs_queue" "queue" {
  name                        = "queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  tags = {
    Name        = "${var.environment}-sqs-queue"
    Environment = var.environment
  }
}

resource "aws_sns_topic" "topic" {
  name                        = "topic"
}

resource "aws_sns_topic_subscription" "topic-subscription" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = "kate.voskresenska@gmail.com"
}

