data "aws_ami" "ubuntu"{
  most_recent = true
  filter {
    name = "name"
    //values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    values = ["hamza-elaouane-nodejs-*"]
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

  # The VPC Subnet
  subnet_id = element(var.public-subnets, 0 )

  # The security Groups
  vpc_security_group_ids = [aws_security_group.allow-ssh-single.id]

  # Public key SSH key
  key_name = aws_key_pair.awssingle.key_name
  tags = {
    Name = "Bastion-instance-${var.ENV}"
    Environment = var.ENV
  }

}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-west-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name  = var.INSTANCE_DEVICE_NAME
  volume_id    = aws_ebs_volume.ebs-volume-1.id
  instance_id  = aws_instance.instance.id
  skip_destroy = true                            # skip destroy to avoid issues with terraform destroy
}



resource "aws_key_pair" "awssingle" {
  key_name = "awskey-single-Bastion-${var.ENV}"
  public_key = "${file(var.path_to_public_key)}"
}