resource "aws_instance" "pathnexpractice" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.default_instance_type
    subnet_id = data.aws_vpc.default.id
}