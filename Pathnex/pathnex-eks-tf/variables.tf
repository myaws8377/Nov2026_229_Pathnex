variable "aws_region" {
  type = string
  default = "ap-south-2"
}

variable "cluster_name" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "environment" {
  type = string
  default = "Dev-Environment"
}

variable "IAMARN" {
  type = string
}

variable "VPCDefault" {
  type = bool
  default = true
}

#variable "SubnetDefault" {
#  type = string
#}

variable "DefaultSecurityGroup" {
  type = string
}

variable "EKSVersion" {
  type = string
}

variable "support_type" {
  type = string
}

variable "All-IPV4" {
  type = string
}