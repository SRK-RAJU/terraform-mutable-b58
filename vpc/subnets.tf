resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.main.id
 # cidr_block        = element(var.public_subnet_cidr, count.index)
  cidr_block        = element(var.public_subnet_cidr, count.index).rendered
  availability_zone = element(var.AZS, count.index)

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}


resource "aws_subnet" "private" {
  depends_on        = [aws_route_table.private]
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.main.id
 # cidr_block        = element(var.private_subnet_cidr, count.index)
  cidr_block        = element(var.private_subnet_cidr, count.index).rendered
  availability_zone = element(var.AZS, count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}
