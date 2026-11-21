#Creating Script to create EC2 instance using AWS CLI
#!/usr/bin/sh

#Enable Strict Mode
set -euo pipefail

#Creating EC2 instance using AWS CLI
run_instance(){
    echo "Creating EC2 instance with Default Parameters"

err_file=$(mktemp)
trap 'rm -f "$err_file"' EXIT

exit_code=0
stdout_data=$(aws ec2 run-instances --image-id 'ami-0d058586402be6010' --instance-type 't3.micro'  \
--key-name 'ec2-ssh' --count 1 --security-group-ids sg-0d39250cd7ab26a5e \
--subnet-id subnet-0c4a1711fe8aeb452 2>"$err_file") || exit_code=$?
stderr_data=$(<"$err_file")

if [[ $exit_code -ne 0 ]]; then
    echo "Failed ($exit_code): $stderr_data" >&2
else
    echo "Succeeded: $stdout_data"
    [[ -n "$stderr_data" ]] && echo "Warnings: $stderr_data" >&2
fi
}

run_instance