resource "aws_security_group" "allow_pg_connection" {
  name        = "allow_pg_connection"
  description = "Ingress for pg_connection"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = var.pg_ingress_port
    to_port          = var.pg_ingress_port
    protocol         = "tcp"
    cidr_blocks      = var.pg_sg_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.private_subnet_id
}

resource "aws_db_instance" "default" {
  identifier                          = var.pg_db_identifier
  allocated_storage                   = var.pg_db_allocated_storage
  engine                              = var.pg_db_engine
  engine_version                      = var.pg_db_engine_version
  instance_class                      = var.pg_db_instance_class
  name                                = var.pg_db_name
  username                            = var.pg_db_username
  password                            = var.pg_db_pwd
  parameter_group_name                = var.pg_db_parameter_group_name
  skip_final_snapshot                 = var.pg_db_skip_final_snapshot
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  vpc_security_group_ids              = [aws_security_group.allow_pg_connection.id]
  db_subnet_group_name                = aws_db_subnet_group.default.name 
}