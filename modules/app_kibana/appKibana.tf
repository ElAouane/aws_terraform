data "aws_ami" "ubuntu"{
  most_recent = true
  filter {
    name = "name"
    //values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    values = ["hamza-elaouane-kibana-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["569551094392"]
  //owners = ["099720109477"] # Canonical
}

resource "aws_instance" "instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  availability_zone = "eu-west-1b"
  private_ip = "10.0.105.101"

  # The VPC Subnet
  subnet_id = element(var.public-subnets, 4 )

  # The security Groups
  vpc_security_group_ids = [aws_security_group.Kibana-security-group.id]
//  depends_on = [var.ELK-Instance]
  # Public key SSH key
  key_name = aws_key_pair.awssingle.key_name
  tags = {
    Name = "Kibana-instance-${var.ENV}"
    Environment = var.ENV
  }

}
//resource "aws_ebs_volume" "ebs-volume-2" {
//  availability_zone = "eu-west-1b"
//  size              = 20
//  type              = "gp2"
//  tags = {
//    Name = "extra volume data"
//  }
//}
//
//resource "aws_volume_attachment" "ebs-volume-2-attachment" {
//  device_name  = var.INSTANCE_DEVICE_NAME
//  volume_id    = aws_ebs_volume.ebs-volume-2.id
//  instance_id  = aws_instance.instance.id
//  skip_destroy = true                            # skip destroy to avoid issues with terraform destroy
//}



resource "aws_key_pair" "awssingle" {
  key_name = "awskey-kibana-key-${var.ENV}"
  public_key = "${file(var.path_to_public_key)}"
}







data "aws_ami" "logstash"{
  most_recent = true
  filter {
    name = "name"
    //values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    values = ["hamza-elaouane-logstash-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["569551094392"]
  //owners = ["099720109477"] # Canonical
}

resource "aws_instance" "logstash" {
  ami = data.aws_ami.logstash.id
  instance_type = var.instance-type
  availability_zone = "eu-west-1b"
  private_ip = "10.0.105.102"

  # The VPC Subnet
  subnet_id = element(var.public-subnets, 4 )

  # The security Groups
  vpc_security_group_ids = [aws_security_group.Kibana-security-group.id]

  # Public key SSH key
  key_name = aws_key_pair.awssingle.key_name
  tags = {
    Name = "logstash-instance-${var.ENV}"
    Environment = var.ENV
  }

}
//resource "aws_ebs_volume" "ebs-volume-3" {
//  availability_zone = "eu-west-1b"
//  size              = 20
//  type              = "gp2"
//  tags = {
//    Name = "extra volume data"
//  }
//}
//
//resource "aws_volume_attachment" "ebs-volume-3-attachment" {
//  device_name  = var.INSTANCE_DEVICE_NAME_LOG
//  volume_id    = aws_ebs_volume.ebs-volume-3.id
//  instance_id  = aws_instance.instance.id
//  skip_destroy = true                            # skip destroy to avoid issues with terraform destroy
//}