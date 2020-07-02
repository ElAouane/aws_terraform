variable "ENV" {}
variable "instance-type"{ default = "t2.micro" }
variable "private-subnets" {type = list(string)}
variable "vpc-id" {}
variable "path_to_public_key"{
  default = "./ssh/awssingle.pub"
}
//variable "user_data_primary" {}
//variable "user_data_secondary" {}

//variable "allow-ssh-single" {}

variable "elastic-security-group" {}