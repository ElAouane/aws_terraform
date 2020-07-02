variable "ENV" {}
variable "private-subnets" {}
variable "vpc-id" {}
variable "rds_password" {
  default = "myrandompassword"
}
variable "allow-ssh-single" {}