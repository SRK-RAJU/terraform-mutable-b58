resource "aws_vpc" "main" {
  cidr_block           = var.public_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.env
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "private_cidr" {
  count      = length(var.private_vpc_cidr)
  vpc_id     = aws_vpc.main.id
 # cidr_block = element(var.private_vpc_cidr, count.index)
  cidr_block = element(var.private_vpc_cidr)[count.index].rendered
}
