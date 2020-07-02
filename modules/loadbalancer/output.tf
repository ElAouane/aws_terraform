output "elastic-load-balancer" {
  value = aws_elb.elastic-load-balancer.name
}

output "ELB" {
  value = aws_elb.elastic-load-balancer.dns_name
}

