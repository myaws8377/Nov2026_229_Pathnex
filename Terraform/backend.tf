terraform {
  backend "s3" {
    bucket = "sathyamurali"
    key    = "batch/oct/ansible/terraform.tfstate"
    region = "ap-south-2"
    #   dynamodb_table = "terraform-locks" # optional but recommended
    use_lockfile = true
    encrypt      = true
    depends_on    = [resource.aws_s3_bucket.terraform_state]
  }
}
# If you are using local backend you can comment above code.

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
resource "aws_s3_bucket" "terraform_state" {
  bucket = "sathyamurali"
}