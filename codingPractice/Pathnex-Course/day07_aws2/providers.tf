terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

# Development provider configuration
provider "aws" {
  region = var.default_region
  alias = "dev"
  profile = "dev"
}