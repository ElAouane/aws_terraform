resource "aws_security_group" "myinstance" {
  vpc_id      = var.vpc-id
  name        = "myinstance"
  description = "security group for my instance"
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
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "myinstance"
  }
}

resource "aws_security_group" "elb-security-group" {
  vpc_id = var.vpc-id
  name = "elb-${var.ENV}"
  description = "Security group for load balancer"
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "elb-${var.ENV}"
  }
}

resource "aws_security_group" "allow-ssh" {
  vpc_id = var.vpc-id
  name = "allow-ssh-${var.ENV}"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
    Environment = var.ENV
  }
}