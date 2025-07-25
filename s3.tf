resource "aws_s3_bucket" "kops_state" {
  bucket = var.bucket_name

  tags = {
    Name        = "kops-state-store"
    Environment = "prod"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.kops_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
