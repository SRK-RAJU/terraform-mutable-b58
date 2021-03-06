env                    = "dev"
public_vpc_cidr        = "10.255.0.0/24"
private_vpc_cidr       = ["10.0.0.0/22"]
public_subnet_cidr     = ["10.255.0.0/25", "10.255.0.128/25"]
private_subnet_cidr    = ["10.0.0.0/23", "10.0.2.0/23"]
AZS                    = ["us-east-1c", "us-east-1d"]
default_vpc            = "vpc-01978b7c726709d98"
default_vpc_cidr       = "172.31.0.0/16"
private_hosted_zone_id = "Z034785541G9EV6BV8GL"