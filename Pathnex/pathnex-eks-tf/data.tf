#Auto Discover VPC and Subnets
data "aws_vpc" "DefaultSelected" {
  default = var.VPCDefault
  #tags = {Tier = "Default VPC"}
}

data "aws_subnets" "public" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.DefaultSelected.id]
  }
}

data "aws_security_groups" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.DefaultSelected.id]
  }
  filter {
    name = "group-name"
    values = ["default"]
  }
}