resource "aws_subnet" "ec2" {
  for_each = {
    "a" = { az = var.availability_zones[0], cidr = var.ec2_subnet_cidrs[0] },
    "c" = { az = var.availability_zones[1], cidr = var.ec2_subnet_cidrs[1] }
  }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.vpc_name}-ec2-${each.key}"
  }
}

resource "aws_subnet" "rds" {
  for_each = {
    "a" = { az = var.availability_zones[0], cidr = var.rds_subnet_cidrs[0] },
    "c" = { az = var.availability_zones[1], cidr = var.rds_subnet_cidrs[1] }
  }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.vpc_name}-rds-${each.key}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-private-rtb"
  }
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "ec2" {
  for_each = aws_subnet.ec2

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "rds" {
  for_each = aws_subnet.rds

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
