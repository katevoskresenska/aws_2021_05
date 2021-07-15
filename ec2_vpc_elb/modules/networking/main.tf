resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.public_availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-${element(var.public_availability_zones, count.index)}-public-subnet"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.private_availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.environment}-${element(var.private_availability_zones, count.index)}-private-subnet"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-public-route-table"
    Environment = var.environment
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-private-route-table"
    Environment = var.environment
  }
}

resource "aws_route" "nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  instance_id             = var.instance_id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_lb_target_group" "target" {
  name = "${var.environment}-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  target_type = "instance"

  health_check {
    enabled = true
    path = "/index.html"
    port = 80
    protocol = "HTTP"
  }

  tags = {
    Name        = "${var.environment}-target"
    Environment = var.environment
  }
}

resource "aws_lb_target_group_attachment" "public" {
  target_group_arn = aws_lb_target_group.target.arn
  port             = 80
  target_id        = var.webserver_id
}

resource "aws_lb_target_group_attachment" "private" {
  target_group_arn = aws_lb_target_group.target.arn
  port             = 80
  target_id        = var.private_instance_id
}

resource "aws_lb" "application_lb" {
  name               = "application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg_id]
  subnets            = [aws_subnet.public_subnet[0].id, aws_subnet.private_subnet[0].id]

  tags = {
    Name        = "${var.environment}-lb"
    Environment = var.environment
  }

}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.application_lb.id
  port = 80

  default_action {
    target_group_arn = aws_lb_target_group.target.id
    type             = "forward"
  }
}