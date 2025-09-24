// VPC 생성
resource "aws_vpc" "user00-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "user00-vpc"
  }
}

// subnet 생성
resource "aws_subnet" "user00-public01" {
  vpc_id            = aws_vpc.user00-vpc.id 
  cidr_block        = var.public_subnet_cidr[0] 
  availability_zone = var.azs[0]     

  tags = {
    Name = "user00-public01"
  }
}
resource "aws_subnet" "user00-public02" {
  vpc_id            = aws_vpc.user00-vpc.id 
  cidr_block        = var.public_subnet_cidr[1] 
  availability_zone = var.azs[1]     

  tags = {
    Name = "user00-public02"
  }
}
resource "aws_subnet" "user00-private01" {
  vpc_id            = aws_vpc.user00-vpc.id 
  cidr_block        = var.private_subnet_cidr[0] 
  availability_zone = var.azs[0]     

  tags = {
    Name = "user00-private01"
  }
}
resource "aws_subnet" "user00-private02" {
  vpc_id            = aws_vpc.user00-vpc.id 
  cidr_block        = var.private_subnet_cidr[1] 
  availability_zone = var.azs[1]     

  tags = {
    Name = "user00-private02"
  }
}

// Internet Gateway 생성
resource "aws_internet_gateway" "user00-igw" {
  vpc_id = aws_vpc.user00-vpc.id

  tags = {
    Name = "user00-igw"
  }   
}

// EIP 생성
resource "aws_eip" "user00-eip" {
  domain = "vpc"
  #depends_on = [ "aws_internet_gateway.user00-igw" ]
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "user00-eip"
  }
}
// NAT Gateway 생성
resource "aws_nat_gateway" "user00-nat-gw" {
  allocation_id = aws_eip.user00-eip.id
  subnet_id     = aws_subnet.user00-public01.id
  depends_on    = [ "aws_internet_gateway.user00-igw" ]
  tags = {
    Name = "user00-nat-gw"
  }  
}

// Public Route Table 생성
resource "aws_default_route_table" "user00-public-rt" {
  default_route_table_id = aws_vpc.user00-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.user00-igw.id
  }
  tags = {
    Name = "user00-public-rt"
  }
}

// Public Subnet 과 Route Table 연결
resource "aws_route_table_association" "user00-public01-rt-assoc" {
  subnet_id      = aws_subnet.user00-public01.id
  route_table_id = aws_default_route_table.user00-public-rt.id
}
resource "aws_route_table_association" "user00-public02-rt-assoc" {
  subnet_id      = aws_subnet.user00-public02.id
  route_table_id = aws_default_route_table.user00-public-rt.id
}

// Private Route Table 생성
resource "aws_route_table" "user00-private-rt" {
  vpc_id = aws_vpc.user00-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.user00-nat-gw.id
  }
  tags = {
    Name = "user00-private-rt"
  }
}

// Private subnet 과 Private Route Table 연결
resource "aws_route_table_association" "user00-private01-rt-assoc" {
  subnet_id      = aws_subnet.user00-private01.id
  route_table_id = aws_route_table.user00-private-rt.id
}
resource "aws_route_table_association" "user00-private02-rt-assoc" {
  subnet_id      = aws_subnet.user00-private02.id
  route_table_id = aws_route_table.user00-private-rt.id
}
