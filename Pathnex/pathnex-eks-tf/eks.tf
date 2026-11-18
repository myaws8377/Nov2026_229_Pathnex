resource "aws_eks_cluster" "pathnex" {
  name     = var.cluster_name
  #ARN OF IAM Cluster ROLE for EKS
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.EKSVersion

  upgrade_policy {
    support_type = var.support_type
  }

  vpc_config {
    subnet_ids = data.aws_subnets.public.ids
    security_group_ids = data.aws_security_groups.default.ids
    endpoint_public_access  = true
    endpoint_private_access = true
    public_access_cidrs = [var.All-IPV4]
  }
  zonal_shift_config {
         enabled = false
        }
}
