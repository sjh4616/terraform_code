// VPC 생성
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

// subnet 생성
resource "aws_subnet" "public01" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "${var.prefix}-public01"
  }
}
resource "aws_subnet" "public02" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr[1]
  availability_zone = var.azs[1]

  tags = {
    Name = "${var.prefix}-public02"
  }
}
resource "aws_subnet" "private01" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "${var.prefix}-private01"
  }
}
resource "aws_subnet" "private02" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr[1]
  availability_zone = var.azs[1]

  tags = {
    Name = "${var.prefix}-private02"
  }
}

// Internet Gateway 생성
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

// EIP 생성
resource "aws_eip" "eip" {
  domain = "vpc"
  #depends_on = [ "aws_internet_gateway.user00-igw" ]
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "${var.prefix}-eip"
  }
}
// NAT Gateway 생성
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public01.id
  depends_on    = ["aws_internet_gateway.igw"]
  tags = {
    Name = "${var.prefix}-nat-gw"
  }
}

// Public Route Table 생성
resource "aws_default_route_table" "public-rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}-public-rt"
  }
}

// Public Subnet 과 Route Table 연결
resource "aws_route_table_association" "public01-rt-assoc" {
  subnet_id      = aws_subnet.public01.id
  route_table_id = aws_default_route_table.public-rt.id
}
resource "aws_route_table_association" "public02-rt-assoc" {
  subnet_id      = aws_subnet.public02.id
  route_table_id = aws_default_route_table.public-rt.id
}

// Private Route Table 생성
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "${var.prefix}-private-rt"
  }
}

// Private subnet 과 Private Route Table 연결
resource "aws_route_table_association" "private01-rt-assoc" {
  subnet_id      = aws_subnet.private01.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_route_table_association" "private02-rt-assoc" {
  subnet_id      = aws_subnet.private02.id
  route_table_id = aws_route_table.private-rt.id
}
