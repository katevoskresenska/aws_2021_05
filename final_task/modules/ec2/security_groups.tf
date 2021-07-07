
resource "aws_security_group" "public_sg" {
  name        = "allow_ssh_http"
  description = "Ingress for ssh_http"
  vpc_id      = var.vpc_id
  tags = {
    Name        = "${var.environment}-public-sg"
    Environment = var.environment
  }

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
}

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
      cidr_blocks = var.public_subnets_cidr
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