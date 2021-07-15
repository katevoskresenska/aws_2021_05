resource "aws_security_group" "private_sg" {
  name        = "allow_ssh_http_icmp"
  description = "Ingress for ssh_http_icmp"
  vpc_id      = var.vpc_id
  tags = {
    Name        = "${var.environment}-private-sg"
    Environment = var.environment
  }
  
  dynamic "ingress" {
    for_each = [
        for rule in var.rules: {
            port = rule.port
            protocol = rule.protocol
        }
    ]
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [var.private_sg_cidr_block]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "private_instance" {
  ami                    = var.instanse_ami
  instance_type          = var.instanse_type
  key_name               = var.instanse_key_name
  subnet_id              = element(var.subnet_id, 0)
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  

  tags = {
    Name = "${var.environment}-private-ec2"
    Environment = var.environment
  }
}