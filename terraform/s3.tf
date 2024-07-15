# Creating an S3 Bucket
resource "aws_s3_bucket" "static_files" {
  bucket = "pfe-static-files"

  tags = {
    Name = "MyAppStaticFiles"
  }
}

# Setting Bucket Policy
resource "aws_s3_bucket_policy" "static_files_policy" {
  bucket = aws_s3_bucket.static_files.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:GetObject"
        Effect = "Allow"
        Resource = "${aws_s3_bucket.static_files.arn}/*"
        Principal = "*"
      }
    ]
  })
}

# Creating an S3 Bucket for Logs (Optional)
resource "aws_s3_bucket" "logs" {
  bucket = "pfe-logs"

  tags = {
    Name = "MyAppLogs"
  }
}

