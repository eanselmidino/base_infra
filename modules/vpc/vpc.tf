resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "vpc-${var.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public_subnet-${each.key}-${var.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]
  tags = {
    "Name" = "private_subnet-${each.key}-${var.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw vpc virginia-${var.sufix}"
  }
}


resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "crt-public-${var.sufix}"
  }
}

resource "aws_route_table" "private_crt" {
  for_each = var.private_subnets
  vpc_id   = aws_vpc.vpc.id
  tags = {
    Name = "crt-private-${each.key}-${var.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_route_table_association" "crta_private_subnet" {
  for_each       = var.private_subnets
  subnet_id      = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.private_crt[each.key].id
}

# NATGW

resource "aws_eip" "eips" {
  count      = var.natgw ? 1 : 0
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "eip-${count.index}-${var.sufix}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = var.natgw ? 1 : 0
  allocation_id = aws_eip.eips[count.index].id
  subnet_id     = aws_subnet.public_subnet["subnet_a"].id
  depends_on    = [aws_internet_gateway.igw, aws_eip.eips]
  tags = {
    Name = "ngw-${count.index}-${var.sufix}"
  }
}

resource "aws_route" "private_sunets_internet_route" {
  for_each               = var.private_subnets
  route_table_id         = aws_route_table.private_crt[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[0].id
}



