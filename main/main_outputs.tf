output "ec2_database_private_ip" {
  value       = try(aws_instance.database[0].private_ip, null)
  description = "private IP of EC2 database instance"
}
