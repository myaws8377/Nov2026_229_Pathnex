#resource "aws_eks_node_group" "pathnex-NG" {
#  cluster_name    = aws_eks_cluster.pathnex.name
#  node_group_name = "pathnex-ng"
#
#  node_role_arn = "arn:aws:iam::968134752304:role/eks-node-role"
#
#  subnet_ids = [
#    "subnet-060e30fbb2ffaa857",
#    "subnet-096709d64d3725b7f"
#  ]
#
#  ami_type       = "AL2023_x86_64_STANDARD"
#  capacity_type  = "SPOT"
#  instance_types = ["c7i-flex.large"]
#  disk_size      = 20
#
#  scaling_config {
#    desired_size = 1
#    min_size     = 1
#    max_size     = 1
#  }
#
#  update_config {
#    max_unavailable = 1
#    update_strategy = "DEFAULT"
#  }
#
#  remote_access {
#    ec2_ssh_key = "Pathnex-ec2-key"
#
#    source_security_group_ids = [
#      "sg-006c76c984d9e1309"
#    ]
#  }
#}
