//resource "aws_security_group" "mongodb_security_group" {
//  vpc_id = var.vpc-id
//  name = "mongodb-security-group-${var.ENV}"
//  description = "security group that allows ssh and all egress traffic"
//
//  egress {
//    from_port = 0
//    protocol = "-1"
//    to_port = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  ingress {
//    from_port = 22
//    protocol = "tcp"
//    to_port = 22
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  ingress {
//  from_port = 1024
//  protocol = "tcp"
//  to_port = 65535
//  cidr_blocks = ["0.0.0.0/0"] #my ip
//
//  }
//
//  egress {
//  from_port = 1024
//  protocol = "tcp"
//  to_port = 65535
//  cidr_blocks = ["0.0.0.0/0"] # my ip
//
//  }
//  tags = {
//    Name = "allow-ssh"
//    Environment = var.ENV
//  }
//
//}


resource "aws_security_group" "mongodb_security_group"{
  name = "MongoDB security group"
  vpc_id = var.vpc-id
  description = "MongoDB security group"

  ingress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
    cidr_blocks = ["10.0.1.0/24"]
  }
  egress {
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
    cidr_blocks = ["10.0.2.0/24"]
  }
  egress {
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
    cidr_blocks = ["10.0.3.0/24"]
  }
  egress {
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
    cidr_blocks = ["10.0.101.0/24"]
  }

  egress {
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
    cidr_blocks = ["10.0.102.0/24"]
  }
  egress {
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
    cidr_blocks = ["10.0.103.0/24"]
  }

  egress {
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
    cidr_blocks = ["10.0.104.0/24"]
  }
  egress {
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
    cidr_blocks = ["10.0.105.0/24"]
  }
  ingress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    security_groups = [var.elastic-security-group]
  }
  egress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    security_groups = [var.elastic-security-group]
  }
//  ingress {
//    from_port = 22
//    protocol = "tcp"
//    to_port = 22
//    security_groups = [var.allow-ssh-single]
//  }
//
//  egress {
//    from_port = 22
//    protocol = "tcp"
//    to_port = 22
//    security_groups = [var.allow-ssh-single]
//  }


}

//resource "aws_security_group_rule" "mongo_inbound" {
//  from_port = 1024
//  protocol = "tcp"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 65535
//  type = "ingress"
//  cidr_blocks = ["10.0.0.0/16"]
//}

//resource "aws_security_group_rule" "mongo_outbound_primary" {
//  from_port = 27017
//  protocol = "tcp"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 27017
//  type = "egress"
//  cidr_blocks = ["10.0.1.0/24"]
//}

//resource "aws_security_group_rule" "mongo_outbound_secondary" {
//  from_port = 27017
//  protocol = "tcp"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 27017
//  type = "egress"
//  cidr_blocks = ["10.0.2.0/24"]
//}
//resource "aws_security_group_rule" "mongo_outbound_secondary2" {
//  from_port = 27017
//  protocol = "tcp"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 27017
//  type = "egress"
//  cidr_blocks = ["10.0.3.0/24"]
//}

//resource "aws_security_group_rule" "mongo_outbound_bastion" {
//  from_port = 27017
//  protocol = "tcp"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 27017
//  type = "egress"
//  cidr_blocks = ["10.0.101.0/24"]
//}

//resource "aws_security_group_rule" "mongo_outbound_instance1" {
//  from_port = 27017
//  protocol = "tcp"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 27017
//  type = "egress"
//  cidr_blocks = ["10.0.102.0/24"]
//}

//resource "aws_security_group_rule" "mongo_outbound_instance2" {
//  from_port = 27017
//  protocol = "tcp"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 27017
//  type = "egress"
//  cidr_blocks = ["10.0.103.0/24"]
//}

//resource "aws_security_group_rule" "mongo_outbound_instance3" {
//  from_port = 27017
//  protocol = "tcp"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 27017
//  type = "egress"
//  cidr_blocks = ["10.0.104.0/24"]
//}

//resource "aws_security_group_rule" "mongo_outbound_kibana" {
//  from_port = 27017
//  protocol = "tcp"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 27017
//  type = "egress"
//  cidr_blocks = ["10.0.105.0/24"]
//}

//resource "aws_security_group_rule" "ssh-awssingle" {
//  from_port = 22
//  protocol = "tcp"
//  security_group_id = var.allow-ssh-single
//  to_port = 22
//  type = "ingress"
//}

//resource "aws_security_group_rule" "ssh-awssingle-out" {
//  from_port = 0
//  protocol = "-1"
//  security_group_id = aws_security_group.mongodb_security_group.id
//  to_port = 0
//  type = "egress"
//  cidr_blocks = ["0.0.0.0/0"]
//}
//resource "aws_security_group_rule" "allow_all" {
//  security_group_id = aws_security_group.mongodb_security_group.id
//  from_port = 0
//  protocol = "-1"
//  to_port = 0
//  cidr_blocks = ["0.0.0.0/0"]
//  type = "ingress"
//}
