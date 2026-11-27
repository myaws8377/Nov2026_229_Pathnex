For best practice

Step 1 - Create S3 Profile for backend
Step 2 - Create Infrastrue Profile for rest of the work like to create EC2
Step 3 - Update ~/.aws/config with these two profiles.

Sample
[default]
region = regions-name

[profile Any Name]
role_arn = arn:aws:iam::123456789:role/S3BucketCreatorRole-Custom
source_profile = default
region = ap-south-2

[profile AnyName]
role_arn = arn:aws:iam::123456789:role/TerraformInfrastructureRole
source_profile = default
region = ap-south-2

Step 4 - Add profile in Terraform for S3 and Provider

Step 5 - Create IAM Custom TerraformInfrastructureRole and attach TerraformInfrastructurePolicy-Custom Policy