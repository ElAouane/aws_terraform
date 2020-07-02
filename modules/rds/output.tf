output "rds" {
  value = aws_db_instance.mariadb.endpoint
}