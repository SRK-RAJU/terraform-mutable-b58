resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
 # cidr_block = ["${var.default_vpc_cidr}"]

  route = [
    {
     cidr_block                 = ["${var.default_vpc_cidr}"]
      #cidr_block                 = cidr_block
      egress_only_gateway_id     = ""
      network_interface_id       =""
      core_network_arn           = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_peering_connection_id  = aws_vpc_peering_connection.peer.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      local_gateway_id           = ""
      vpc_endpoint_id            = ""
    },
    {
      cidr_block                 = "0.0.0.0/0"
      core_network_arn           = ""
      network_interface_id       =""
      egress_only_gateway_id     = ""
      gateway_id                 = aws_internet_gateway.gw.id
      instance_id                = ""
      ipv6_cidr_block            = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_peering_connection_id  = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      local_gateway_id           = ""
      vpc_endpoint_id            = ""
    }
  ]

  tags = {
    Name = "public-rt-${var.env}-vpc"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
 # cidr_block = var.default_vpc_cidr

  route = [
    {
      cidr_block                 = ["${var.default_vpc_cidr}"]
    #  cidr_block                 = cidr_block
      egress_only_gateway_id     = ""
      network_interface_id       =""
      core_network_arn           = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_peering_connection_id  = aws_vpc_peering_connection.peer.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      local_gateway_id           = ""
      vpc_endpoint_id            = ""
    },
    {
      cidr_block                 = "0.0.0.0/0"
      egress_only_gateway_id     = ""
      network_interface_id       =""
      core_network_arn           = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      nat_gateway_id             = aws_nat_gateway.ngw.id
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_peering_connection_id  = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      local_gateway_id           = ""
      vpc_endpoint_id            = ""
    }
  ]

  tags = {
    Name = "private-rt-${var.env}-vpc"
  }
}


resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public.*.id)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private.*.id)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "default-vpc-route-table-public" {
  //count                     = length(local.all_cidr_vpc)
  route_table_id = data.aws_vpc.default.main_route_table_id
  //destination_cidr_block    = element(local.all_cidr_vpc, count.index)
  destination_cidr_block    = var.public_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  //depends_on                = [aws_route_table.testing]
}


resource "aws_route" "default-vpc-route-table-private" {
  count                     = length(var.private_vpc_cidr)
  route_table_id            = data.aws_vpc.default.main_route_table_id
  destination_cidr_block    = element(var.private_vpc_cidr, count.index)
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  //depends_on                = [aws_route_table.testing]
}
