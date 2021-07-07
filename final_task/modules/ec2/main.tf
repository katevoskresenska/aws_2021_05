resource "aws_instance" "nat_instance" {
  ami                    = var.nat_instanse_ami
  instance_type          = var.instanse_type
  key_name               = var.instanse_key_name
  subnet_id              = element(var.public_subnet_id, 0)
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  source_dest_check      = false
  iam_instance_profile   = aws_iam_instance_profile.private_instance_profile.id
  
  tags = {
    Name = "${var.environment}-nat-ec2"
    Environment = var.environment
  }
}

resource "aws_instance" "private_instance" {
  ami                    = var.instanse_ami
  instance_type          = var.instanse_type
  key_name               = var.instanse_key_name
  subnet_id              = element(var.private_subnet_id, 0)
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.private_instance_profile.id
  depends_on = [
    aws_instance.nat_instance
  ]
  
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update && sudo apt install -y openjdk-8-jdk awscli
    aws s3 cp s3://${var.bucket_name}/persist3-0.0.1-SNAPSHOT.jar /home/ubuntu/persist3-0.0.1-SNAPSHOT.jar
    export RDS_HOST=${var.pg_connection_address}
    java -jar persist3-0.0.1-SNAPSHOT.jar & > log.txt
  EOF

  tags = {
    Name = "${var.environment}-private-ec2"
    Environment = var.environment
  }
}

resource "aws_launch_template" "template" {
  name_prefix            = "asg"
  image_id               = var.instanse_ami
  instance_type          = var.instanse_type
  key_name               = var.instanse_key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  user_data              = filebase64(var.user_data_file)

  iam_instance_profile {
    name = aws_iam_instance_profile.public_instance_profile.name
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "asg"
  vpc_zone_identifier       = [var.public_subnet_id[0], var.public_subnet_id[1]]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 2

  launch_template {
    id      = aws_launch_template.template.id
  }

  tags = [
    {
      key                 = "Name"
      value               = "${var.environment}-asg-ec2"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = var.environment
      propagate_at_launch = true
    },
  ]
}