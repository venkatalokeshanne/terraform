output "s3_bucket" {
  value = aws_s3_bucket.kops_state.bucket
}

output "vpc_id" {
  value = aws_vpc.kops_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}
