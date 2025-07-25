resource "aws_vpc" "kops_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "kops-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kops_vpc.id

  tags = {
    Name = "kops-gateway"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.kops_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name                                      = "kops-public-subnet"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.kops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
