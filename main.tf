# Create a VPC (virtual network)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Create 2 public subnets in different availability zones for high availability
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.project_name}-public-subnet-${count.index}"
  }
}

# Create S3 bucket to store Kubernetes state
resource "aws_s3_bucket" "kops_state" {
  bucket = "${var.project_name}-kops-state"
  acl    = "private"

  versioning {
    enabled = true
  }
}

# Get availability zones for subnet placement
data "aws_availability_zones" "available" {}
