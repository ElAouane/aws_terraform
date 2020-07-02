resource "aws_security_group" "allow-mariadb" {
  vpc_id = var.vpc-id
  name        = "allow-mariadb"
  description = "allow-mariadb"
  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [var.allow-ssh-single]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "Allow-mariadb"
  }
}

resource "aws_security_group" "allow-ssh" {
  vpc_id      = var.vpc-id
  name        = "allow-ssh-rds"
  description = "security group that allows ssh and myip traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
  }
}