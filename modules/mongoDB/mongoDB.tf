data "aws_ami" "primary"{
  most_recent = true
  filter {
    name = "name"
    //values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    values = ["hamza-elaouane-mongodb-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["569551094392"]
  //owners = ["099720109477"] # Canonical
}

data "template_file" "initdb1" {
  template = file("../dev/template/db/init1.sh.tpl")
}

data "template_file" "initdb2" {
  template = file("../dev/template/db/init2.sh.tpl")
}


resource "aws_key_pair" "awssingle" {
  key_name = "awskey-single-mongo-${var.ENV}"
  public_key = "${file(var.path_to_public_key)}"
}

resource "aws_instance" "primary-db" {
  ami = data.aws_ami.primary.id
  instance_type = var.instance-type

  # The VPC Subnet
  subnet_id = element(var.private-subnets, 0 )
  private_ip = "10.0.1.100"

  # The security Groups
  vpc_security_group_ids = [aws_security_group.mongodb_security_group.id]
  user_data = data.template_file.initdb1.rendered


  # Public key SSH key
  key_name = aws_key_pair.awssingle.key_name
  tags = {
    Name = "Mongodb-Primary-${var.ENV}"
    Environment = var.ENV
  }

}

resource "aws_instance" "secondary-db" {
  ami = data.aws_ami.primary.id
  instance_type = var.instance-type

  # The VPC Subnet
  subnet_id = element(var.private-subnets, 1 )
  private_ip = "10.0.2.100"

  # The security Groups
  vpc_security_group_ids = [aws_security_group.mongodb_security_group.id]
  user_data = data.template_file.initdb2.rendered

  # Public key SSH key
  key_name = aws_key_pair.awssingle.key_name
  tags = {
    Name = "MongoDB-secondary-${var.ENV}"
    Environment = var.ENV
  }

}

resource "aws_instance" "tertiary-db" {
  ami = data.aws_ami.primary.id
  instance_type = var.instance-type

  # The VPC Subnet
  subnet_id = element(var.private-subnets, 2 )
  private_ip = "10.0.3.100"

  # The security Groups
  vpc_security_group_ids = [aws_security_group.mongodb_security_group.id]
  user_data = data.template_file.initdb2.rendered

  # Public key SSH key
  key_name = aws_key_pair.awssingle.key_name
  tags = {
    Name = "MongoDB-tertiary-${var.ENV}"
    Environment = var.ENV
  }

}
