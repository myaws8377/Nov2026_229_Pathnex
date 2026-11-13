terraform {
  backend "s3" {
    bucket         = "pathnex-devops-terraform"
    key            = "batch/may/ansible/terraform.tfstate"
    region         = "ap-south-1"
  # dynamodb_table = "terraform-locks-aug" # optional but recommended
    encrypt        = true
    use_lockfile = true
  }
}


# If you are using local backend you can comment above code.
