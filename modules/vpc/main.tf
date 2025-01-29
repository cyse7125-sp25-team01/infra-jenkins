data "aws_availability_zones" "available" {}

resource "aws_vpc" "app_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

locals {
  public_subnet_count  = 3
  private_subnet_count = 3

  public_subnet_cidrs = [
    for i in range(0, local.public_subnet_count) : cidrsubnet(var.vpc_cidr, 8, i)
  ]


  private_subnet_cidrs = [
    for i in range(0, local.private_subnet_count) : cidrsubnet(var.vpc_cidr, 8, local.public_subnet_count + i)
  ]
}

resource "aws_subnet" "public_subnet" {
  count                   = local.public_subnet_count
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = local.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = local.private_subnet_count
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = local.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "vpc_gateway" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "public_route_tbl" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route_table" "private_route_tbl" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_tbl.id
  destination_cidr_block = var.destination_cidr
  gateway_id             = aws_internet_gateway.vpc_gateway.id
}

resource "aws_route_table_association" "public_route_tbl_assc" {
  count          = local.public_subnet_count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_tbl.id
}

resource "aws_route_table_association" "private_route_tbl_assc" {
  count          = local.private_subnet_count
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_tbl.id
}