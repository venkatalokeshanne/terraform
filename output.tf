output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.kops_state.bucket
}
