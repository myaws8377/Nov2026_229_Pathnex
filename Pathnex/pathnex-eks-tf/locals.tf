# Dynamically Fetch
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

variable "name_prefix" {
  type = string
  default = "pathnex"
}

locals {
  # Fetch from iam_actions.yaml
  iam_policy_catalog = yamldecode(file("${path.module}/iam_actions.yaml"))
  policy_prefix = "${var.name_prefix}-"
  partition = data.aws_partition.current.partition
  account_id = data.aws_caller_identity.current.account_id

  # arn:aws:iam::<account>:policy/pathnex-*
  pathnex_policy_arn_pattern = "arn:${local.partition}:iam::${local.account_id}:policy/${local.policy_prefix}"

  # Reusable IAM policies
  policies = {
    AmzEKSClusPol = {
      description = "Manage Policy and Policy Version"
      statements = [{
        sid = "ManagePolicy"
        Actions = distinct(flatten(values(local.iam_policy_catalog)))

        Resources = [local.pathnex_policy_arn_pattern]
      }]
    }
  }
}
