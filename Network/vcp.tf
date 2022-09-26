
data "aws_availability_zones" "available" {}

resource "random_shuffle" "zone_location" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}
resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "VPC-${var.project}"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id

  count                   = var.public_sn_count
  cidr_block              = var.public_Network_CID[count.index]
 # cidr_block              = "${var.public_Network_CID}"
  map_public_ip_on_launch = "true"
  availability_zone = random_shuffle.zone_location.result[count.index]
  #availability_zone       = var.location_subnet

  tags = {
    "Name" = "public-subnet"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "public-route-table"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }

}

resource "aws_route_table_association" "public-rta" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.public-subnet.*.id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.vpc.id

  count                   = var.private_sn_count
  cidr_block              = var.private_Network_CID[count.index]
  map_public_ip_on_launch = "false"
  availability_zone = random_shuffle.zone_location.result[count.index]
  #availability_zone       = var.location_subnet

  tags = {
    "Name" = "private-subnet"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "internet-gw"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }

  tags = {
    "Name" = "public-route-table"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
} 

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet-gw.id
}

resource "aws_default_route_table" "private_rt" {

  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    "Name" = "private_route_table"
    "Project" = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}