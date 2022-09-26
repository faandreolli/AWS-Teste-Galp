resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_Network_CIDR 
  availability_zone = var.location_public_subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
    Environment = var.environment
    Project = var.project
  }

  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_Network_CIDR
  availability_zone = var.location_private_subnet
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet"
    Environment = var.environment
    Project = var.project
  }

  depends_on = [
    aws_vpc.vpc
  ]
}