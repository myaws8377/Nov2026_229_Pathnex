data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

data "aws_vpc" "default" {
    default = true

}

data "aws_subnets" "default_public_subnets" {
    filter {
      name = "vpc-id"
      values = [ data.aws_vpc.default.id ]
    }
}

data "aws_security_group" "default" {
    vpc_id = data.aws_vpc.default.id
    # AWS EC2 API Reference for API_DescribeSecurityGroups has default security group
    # has name "group-name" and value as "default"
    filter {
      name = "group-name"
      values = ["default"]
    }
}

data "aws_key_pair" "ec2-ssh" {
    key_name = "ec2-ssh"
}