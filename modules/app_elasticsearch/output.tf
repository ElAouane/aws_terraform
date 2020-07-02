output "elastic-security-group" {
  value = aws_security_group.elk-security-group.id
}

//output "ELK-Instance" {
//  value = aws_instance.instance
//}