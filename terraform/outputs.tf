# Output the public IP of the EC2 instance
output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

# Output the URL of the S3 bucket for static files
output "s3_bucket_url" {
  description = "The URL of the S3 bucket for static files"
  value       = aws_s3_bucket.static_files.bucket_domain_name
}

# Output the RDS endpoint
output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.default.endpoint
}

# Output the RDS username
output "rds_username" {
  description = "The username for the RDS instance"
  value       = aws_db_instance.default.username
}

# Output the RDS database name
output "rds_db_name" {
  description = "The name of the RDS database"
  value       = aws_db_instance.default.name
}

