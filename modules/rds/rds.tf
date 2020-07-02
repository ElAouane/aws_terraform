resource "aws_db_subnet_group" "mariadb-subnet" {
  name        = "mariadb-subnet"
  description = "RED Subnet group"
  subnet_ids  = [element(var.private-subnets,0 ), element(var.private-subnets,1 ), element(var.private-subnets,2 )]
}

resource "aws_db_parameter_group" "mariadb-parameters" {
  name        = "mariadb-parameters"
  family      = "mariadb10.4"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "mariadb" {
  allocated_storage       = 100
  engine                  = "mariadb"
  engine_version          = "10.4"
  instance_class          = "db.t2.micro"
  identifier              = "mariadb"
  name                    = "mariadb"
  username                = "root"
  password                = var.rds_password
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name    = aws_db_parameter_group.mariadb-parameters.name
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 30
  //availability_zone       = element(var.private-subnets,0)
  skip_final_snapshot     = true
  tags = {
    Name = "mariadb-instance"
  }
}