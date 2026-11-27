terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

# Development provider configuration to only create resources in dev environment
provider "aws" {
  region = var.default_region
  alias = "dev"
  profile = "dev"
}

# Infra provider configuration to manage the resources in all environments
provider "aws" {
    region = var.default_region
    alias = "infra"
    profile = "infra"
}