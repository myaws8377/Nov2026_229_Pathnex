terraform {
  backend "s3" {
    bucket = "sathyamurali"
    key    = "batch/oct/ansible/terraform.tfstate"
    region = "ap-south-2"
    #   dynamodb_table = "terraform-locks" # optional but recommended
    use_lockfile = true
    encrypt      = true
  }
}
# If you are using local backend you can comment above code.