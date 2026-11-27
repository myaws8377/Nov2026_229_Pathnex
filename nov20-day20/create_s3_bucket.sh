#Code to create S3 bucket for terraform state file
#!/usr/bin/sh

# Failing the script if any command fails
set -euo pipefail

create_s3_bucket(){
    echo "Creating S3 bucket for terraform state file"
    err_file=$(mktemp)
    trap 'rm -rf "$err_file"' EXIT
    exit_code=0
    stdout_data=$(aws s3api create-bucket --bucket sathyamurali --region ap-south-2 --create-bucket-configuration LocationConstraint=ap-south-2 2>"$err_file") || exit_code=$?
    stderr_data=$(<"$err_file")

if [[ $exit_code -ne 0 ]]; then
    echo "Failed to create S3 bucket ($exit_code): $stderr_data" >&2
else
    echo "S3 bucket created successfully: $stdout_data"
    [[ -n "$stderr_data" ]] && echo "Warnings: $stderr_data" >&2
fi
}

create_s3_bucket