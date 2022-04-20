locals {
  public_vpc_cidr = tolist([var.public_vpc_cidr, ""])
  all_cidr_vpc    = compact(concat(var.private_vpc_cidr, local.public_vpc_cidr))
}