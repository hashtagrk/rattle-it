provider "aws" {
  # The AWS region in which all resources will be created
  region = var.aws_region

  # Provider version 2.X series is the latest, but has breaking changes with 1.X series.
  version = "~> 4.29.0"

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = [var.aws_account_id]
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  count = 3
  cidr_block        = "10.0.${1 + floor(count.index / 2)}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index % 3)
  vpc_id            = aws_vpc.my_vpc.id
  map_public_ip_on_launch = count.index < 3 ? true : false
}

resource "aws_subnet" "private_subnet" {
  count = 6
  cidr_block        = "10.0.${5 + floor(count.index / 2)}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index % 3)
  vpc_id            = aws_vpc.my_vpc.id
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "nat" {
  count = length(aws_subnet.public_subnet)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id = aws_subnet.public_subnet[count.index].id
}

resource "aws_eip" "nat" {
  count = length(aws_subnet.public_subnet)
}