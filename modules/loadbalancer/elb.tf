resource "aws_elb" "elastic-load-balancer" {
  name = "elastic-load-balancer"
  subnets = [element(var.public-subnets, 0), element(var.public-subnets, 1), element(var.public-subnets, 2)]
  security_groups = [var.elb-security-group]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:80/"
    timeout = 3
    unhealthy_threshold = 2
  }
  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb-${var.ENV}"
  }
}