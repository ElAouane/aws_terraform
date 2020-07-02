resource "aws_key_pair" "mykeypair" {
  key_name = "awskey-${var.ENV}"
  public_key = "${file(var.path_to_public_key)}"
}



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
resource "aws_launch_configuration" "autoscaling-launchconfi" {
  name_prefix = "autoscaling-launchconfig"
  image_id = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.myinstance.id]
  user_data       = data.template_cloudinit_config.cloudinit-example.rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "instance-autoscaling" {
  name = "instance"
  launch_configuration = aws_launch_configuration.autoscaling-launchconfi.name
  vpc_zone_identifier = [element(var.public-subnets, 1), element(var.public-subnets, 2), element(var.public-subnets, 3)]
  max_size = 3
  min_size = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  load_balancers = [var.elastic-load-balancer]
  force_delete = true
  tag {
    key                 = "Name"
    value               = "instance-${var.ENV}"
    propagate_at_launch = true
  }
}





