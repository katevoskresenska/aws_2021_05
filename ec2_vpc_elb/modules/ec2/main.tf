resource "aws_security_group" "allow_ssh_http" {
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

resource "aws_instance" "web_server" {
  ami                    = var.instanse_ami
  instance_type          = var.instanse_type
  key_name               = var.instanse_key_name
  subnet_id              = element(var.subnet_id, 0)
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  

  tags = {
    Name = "${var.environment}-public-ec2"
    Environment = var.environment
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y apache2",
      "echo '<h1>Hello Terraform</h1>' | sudo tee /var/www/html/index.html"
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

resource "aws_instance" "nat_instance" {
  ami                    = var.nat_instanse_ami
  instance_type          = var.instanse_type
  key_name               = var.instanse_key_name
  subnet_id              = element(var.subnet_id, 0)
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  source_dest_check      = false
  

  tags = {
    Name = "${var.environment}-nat-ec2"
    Environment = var.environment
  }
}