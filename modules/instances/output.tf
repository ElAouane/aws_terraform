output "allow-ssh-single" {
  value = aws_security_group.allow-ssh-single.id
}

output "instance-ID" {
  value = aws_instance.instance.public_ip
}

output "instance-private-ip" {
  value = aws_instance.instance.private_ip
}