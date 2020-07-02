data "template_file" "init" {
  template = file("./template/init.sh.tpl")
}


module "main-vpc" {
  source = "../modules/vpc"
  ENV = "dev"
  aws_region = var.aws_region
}

module "mongodb" {
  source = "../modules/mongoDB"
  ENV = "dev"
  vpc-id = module.main-vpc.vpc_id
  private-subnets = module.main-vpc.private-subnets
  //allow-ssh-single = module.instances.allow-ssh-single
  elastic-security-group = module.elk-instance.elastic-security-group
}
//module "instances" {
//  source         = "../modules/instances"
//  ENV            = "dev"
//  vpc-id         = module.main-vpc.vpc_id
//  public-subnets = module.main-vpc.public-subnets
//  instance-private-ip = module.instances.instance-ID
//}
module "elk-instance" {
  source = "../modules/app_elasticsearch"
  ENV = "dev"
  vpc-id = module.main-vpc.vpc_id
  public-subnets = module.main-vpc.public-subnets
}

module "kibana-instance" {
  source = "../modules/app_kibana"
  ENV = "dev"
  vpc-id = module.main-vpc.vpc_id
  public-subnets = module.main-vpc.public-subnets
  elastic-security-group = module.elk-instance.elastic-security-group
}

module "autoscaling" {
  source = "../modules/autoscaling"
  ENV = "dev"
  vpc-id = module.main-vpc.vpc_id
  public-subnets = module.main-vpc.public-subnets
  elb-security-group = module.autoscaling.elb-security-group
  elastic-load-balancer = module.load-balancer.elastic-load-balancer
  user_data_npm = data.template_file.init.rendered
//  user_data_node = data.template_file.init_node.rendered
}

module "load-balancer" {
  source = "../modules/loadbalancer"
  ENV = "dev"
  vpc-id = module.main-vpc.vpc_id
  public-subnets = module.main-vpc.public-subnets
  elb-security-group = module.autoscaling.elb-security-group

}

//module "rds" {
//  source = "../modules/rds"
//  ENV = "dev"
//  vpc-id = module.main-vpc.vpc_id
//  private-subnets = module.main-vpc.private-subnets
//  allow-ssh-single = module.instances.allow-ssh-single
//}
