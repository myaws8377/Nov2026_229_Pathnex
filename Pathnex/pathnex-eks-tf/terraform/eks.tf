#resource "aws_eks_cluster" "pathnex" {
#  name     = "Pathnex-Aug-2026-New"
#  role_arn = "arn:aws:iam::968134752304:role/eks-cluster-role1"
#  version  = "1.34"
#
#  vpc_config {
#    subnet_ids = [
#      "subnet-060e30fbb2ffaa857",
#      "subnet-096709d64d3725b7f"
#    ]
#
#    security_group_ids = [
#      "sg-006c76c984d9e1309"
#    ]
#
#    endpoint_public_access  = true
#    endpoint_private_access = true
#
#    public_access_cidrs = [
#      "0.0.0.0/0"
#    ]
#  }
#  zonal_shift_config {
#         enabled = false
#        }
#}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "ap-south-1"
}

# Get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get a subnet from the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# EC2 instance
#resource "aws_instance" "example" {
#  ami           = data.aws_ami.amazon_linux.id
#  instance_type = "t3.micro"
#
#  subnet_id = data.aws_subnets.default.ids[0]
#
#  tags = {
#    Name = "terraform-ec2"
#  }
#}
#
#
resource "aws_instance" "example" {
    ami                                  = "ami-05a1f40ec1f9ea141"
   # arn                                  = "arn:aws:ec2:ap-south-1:968134752304:instance/i-07d6b21f43b3dd4cb"
    associate_public_ip_address          = true
    availability_zone                    = "ap-south-1a"
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    force_destroy                        = false
    get_password_data                    = false
    hibernation                          = false
   # id                                   = "i-07d6b21f43b3dd4cb"
    instance_initiated_shutdown_behavior = "stop"
  #  instance_state                       = "running"
    instance_type                        = "c7i-flex.large"
  #  ipv6_address_count                   = 0
    ipv6_addresses                       = []
    monitoring                           = false
    placement_partition_number           = 0
  #  primary_network_interface_id         = "eni-0de1e1b9076fabab3"
  #  private_dns                          = "ip-172-31-1-120.ap-south-1.compute.internal"
  #  private_ip                           = "172.31.1.120"
  #  public_dns                           = "ec2-13-206-107-48.ap-south-1.compute.amazonaws.com"
  #  public_ip                            = "13.206.107.48"
    region                               = "ap-south-1"
    secondary_private_ips                = []
    security_groups                      = [
        "default",
    ]
    source_dest_check                    = true
    subnet_id                            = "subnet-060e30fbb2ffaa857"
    tags                                 = {
        "Name" = "terraform-ec2"
    }
    tags_all                             = {
        "Name" = "terraform-ec2"
    }
    tenancy                              = "default"
    user_data_replace_on_change          = false
    vpc_security_group_ids               = [
        "sg-006c76c984d9e1309",
    ]

    capacity_reservation_specification {
        capacity_reservation_preference = "open"
    }

    cpu_options {
        core_count       = 1
        threads_per_core = 2
    }

    credit_specification {
        cpu_credits = "unlimited"
    }

    enclave_options {
        enabled = false
    }

    maintenance_options {
        auto_recovery = "default"
    }

    metadata_options {
        http_endpoint               = "enabled"
        http_protocol_ipv6          = "disabled"
        http_put_response_hop_limit = 2
        http_tokens                 = "required"
        instance_metadata_tags      = "disabled"
    }

  #  primary_network_interface {
  #      delete_on_termination = true
  #      network_interface_id  = "eni-0de1e1b9076fabab3"
  #  }

    private_dns_name_options {
        enable_resource_name_dns_a_record    = false
        enable_resource_name_dns_aaaa_record = false
        hostname_type                        = "ip-name"
    }

    root_block_device {
        delete_on_termination = true
  #      device_name           = "/dev/xvda"
        encrypted             = false
        iops                  = 3000
        tags                  = {}
        tags_all              = {}
        throughput            = 125
 #       volume_id             = "vol-027b55ac9bf7d1f07"
        volume_size           = 30
        volume_type           = "gp3"
    }
}




output "instance_id" {
  value = aws_instance.example.id
}

output "public_ip" {
  value = aws_instance.example.public_ip
}