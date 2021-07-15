resource "aws_iam_role" "public" {
    name = "public_role"
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


resource "aws_iam_instance_profile" "public_instance_profile" {
    name = "public_instance_profile"
    role = "public_role"
}


resource "aws_iam_role_policy" "public" {
  name = "public_iam_role_policy"
  role = aws_iam_role.public.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["dynamodb:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["sqs:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["sns:*"],
      "Resource": ["*"]
    }
  ]
}
EOF
}

resource "aws_iam_role" "private" {
    name = "private_role"
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


resource "aws_iam_instance_profile" "private_instance_profile" {
    name = "private_instance_profile"
    role = "private_role"
}

resource "aws_iam_role_policy" "private" {
  name = "private_iam_role_policy"
  role = aws_iam_role.private.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["dynamodb:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["rds-db:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["sqs:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["sns:*"],
      "Resource": ["*"]
    }
  ]
}
EOF
}
