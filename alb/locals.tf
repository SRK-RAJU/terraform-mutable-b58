locals {
  default_vpc_cidr = tolist([data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR, ""])
  all_cidr_vpc     = compact(concat(data.terraform_remote_state.vpc.outputs.VPC_CIDR, local.default_vpc_cidr))
}
