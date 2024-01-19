#s3 buckets
resource "aws_s3_bucket" "webapp-data" {
  bucket = var.bucket_name
  force_destroy = true
  
}

resource "aws_s3_bucket_versioning" "webapp-data" {
  bucket = aws_s3_bucket.webapp-data.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "webapp-data" {
  bucket = aws_s3_bucket.webapp-data.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}