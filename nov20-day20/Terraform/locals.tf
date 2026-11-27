locals {
  instances = {
    ec2-1 = {
      instance_type = "t3.micro"
    }

    ec2-2 = {
      instance_type = ""
    }

    pathnex-3 = {
      instance_type = "t3.small"
    }
  }
}