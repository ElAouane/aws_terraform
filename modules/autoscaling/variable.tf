variable "aws_region" {
  default = "eu-west-1"
}
//variable "amis" {
//  type = map(string)
//  default = {
//    eu-west-1 = "ami-08bb4c47465edc242"
//    eu-west-2 = "ami-0b1912235a9e70540"
//    eu-west-3 = "ami-0b92a0ac418c64fb1"
//  }
//}

variable "instance-type" {default = "t2.micro"}
variable "ENV" {}
variable "path_to_public_key"{
  default = "./ssh/aws.pub"
}
variable "vpc-id"{}
variable "public-subnets" {}
variable "elb-security-group" {}
variable "elastic-load-balancer" {}
variable "user_data_npm" {}
//variable "user_data_node" {}