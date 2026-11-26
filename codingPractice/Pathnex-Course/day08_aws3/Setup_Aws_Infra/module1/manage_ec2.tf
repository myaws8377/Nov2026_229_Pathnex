resource "aws_instance" "pathnexpractice" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.default_instance_type
    key_name = data.aws_key_pair.ec2-ssh.key_name
    subnet_id = data.aws_subnets.default_public_subnets.ids[0]
    vpc_security_group_ids =  [data.aws_security_group.default.id]
}
