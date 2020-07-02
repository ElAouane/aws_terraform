variable "ENV" {}
variable "instance-type"{ default = "t2.small" }
variable "public-subnets" {type = list(string)}
variable "vpc-id" {}
variable "path_to_public_key"{
  default = "./ssh/awssingle.pub"
}
//variable "INSTANCE_DEVICE_NAME" {
//  default = "/dev/xvdh"
//}
//
//variable "INSTANCE_DEVICE_NAME_LOG" {
//  default = "/dev/xvdh"
//}

//variable "ELK-Instance" {}
variable "elastic-security-group" {}