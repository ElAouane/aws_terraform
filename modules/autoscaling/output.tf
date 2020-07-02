output "elb-security-group" {
  value = aws_security_group.elb-security-group.id
}
output "my-instance-sg" {
  value = aws_security_group.myinstance.id
}

