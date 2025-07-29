resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = var.environment
    Name        = "MyS3-${var.environment}"
  }

  versioning {
    enabled = true
  }
}
