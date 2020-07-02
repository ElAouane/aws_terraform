output "vpc_id" {
  description = "The ID of VPC"
  value = module.main-vpc.vpc_id
}

output "private-subnets" {
  description = "List of IDs for the private subnets"
  value = module.main-vpc.private_subnets
}

output "public-subnets" {
  description = "List of IDs for the public subnets"
  value = module.main-vpc.public_subnets
}

output "public-subnets-elk" {
  value = module.main-vpc.public_subnets
}
