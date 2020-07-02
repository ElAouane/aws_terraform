variable "ENV" {}
variable "instance-type"{ default = "t2.micro" }
variable "public-subnets" {type = list(string)}
variable "vpc-id" {}
variable "instance-private-ip" {}
variable "path_to_public_key"{
  default = "./ssh/awssingle.pub"
}
variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}