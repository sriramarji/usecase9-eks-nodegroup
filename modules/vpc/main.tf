# VPC
resource "aws_vpc" "test_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "my-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "my-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = var.public_subnet_1_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnet_1_az

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = var.public_subnet_2_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnet_2_az

  tags = {
    Name = "public-subnet-2"
  }
}

#EIP
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat-gateway"
  }
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.private_subnet_1_cidr_block
  availability_zone = var.private_subnet_1_az

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.private_subnet_2_cidr_block
  availability_zone = var.private_subnet_2_az

  tags = {
    Name = "private-subnet-2"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_route_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_route_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}