# Below code is for ebs csi
resource "aws_iam_role" "ebs_csi" {
  name = "pathnex-AmazonEKSPodIdentityAmazonEBSCSIDriverRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "pods.eks.amazonaws.com"
        }

        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}


# This will help in attaching the policy
resource "aws_iam_role_policy_attachment" "ebs_csi" {
  role       = aws_iam_role.ebs_csi.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_pod_identity_association" "ebs_csi" {
  cluster_name    = aws_eks_cluster.pathnex.name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.ebs_csi.arn

  depends_on = [
    aws_eks_cluster.pathnex,
    aws_iam_role_policy_attachment.ebs_csi
  ]
}

# Below code is for Cluster Autoscaler
resource "aws_iam_role" "cluster_autoscaler" {
  name = "pathnex-ClusterAutoscalerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "pods.eks.amazonaws.com"
        }

        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

# This will help in attaching the policy
resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "pathnex-ClusterAutoscalerPolicy"
  description = "Permissions for Kubernetes Cluster Autoscaler"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeScalingActivities",
          "autoscaling:DescribeTags",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplateVersions",
          "eks:DescribeNodegroup"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup"
        ]

        Resource = "*"

        Condition = {
          StringEquals = {
            "aws:ResourceTag/k8s.io/cluster-autoscaler/enabled" = "true"

            "aws:ResourceTag/k8s.io/cluster-autoscaler/Pathnex-Sep-2026" = "owned"
          }
        }
      }
    ]
  })
}


# Attach policy to role
resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  role       = aws_iam_role.cluster_autoscaler.name
  policy_arn = aws_iam_policy.cluster_autoscaler.arn
}


# Give the Kubernetes ServiceAccount this IAM role
resource "aws_eks_pod_identity_association" "cluster_autoscaler" {
  cluster_name    = aws_eks_cluster.pathnex.name
  namespace       = "kube-system"
  service_account = "cluster-autoscaler"
  role_arn        = aws_iam_role.cluster_autoscaler.arn

  depends_on = [
    aws_eks_addon.pod_identity,
    aws_iam_role_policy_attachment.cluster_autoscaler
  ]
}

#Create IAM Cluster ROLE for EKS
resource "aws_iam_role" "eks_cluster" {
  name = "${var.cluster_name}_dev_eks_cluster"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid = ""
      Principal = {
        Service = "eks.amazonaws.com"
      }
    },
    ]
  })
}

#Attach the above policy
resource "aws_iam_policy_attachment" "eks_cluster_policy" {
  name = "${var.cluster_name}_dev_eks_cluster_policy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles = [aws_iam_role.eks_cluster.name]
}

#Create Custom EKS policy for Terraform apply and destroy
/* resource "aws_iam_policy" "Terraform-Custom-EKS-Manage-Policy" {
  name = "Terraform-Custom-EKS-Manage-Policy"
  description = "This Custom Policy creates access for Terraform to create and delete resources"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action
      }]
  })
} */

# Custom IAM POLICY Document for EKS
data "aws_iam_policy_document" "custom" {
  for_each = local.policies
  dynamic "statement" {
    for_each = each.value.statements
    content {
      sid = statement.value.sid
      effect = "allow"
      actions = [statement.value.Actions]
      resources = [statement.value.Resources]
    }
  }
}


# Custom IAM POLICY for EKS
resource "aws_iam_policy" "custom" {
  for_each = local.policies
  name = each.key
  description = each.value.description
  policy = data.aws_iam_policy_document.custom[each.key].json
}

# Custom IAM POLICY Attachment for EKS
resource "aws_iam_role_policy_attachment" "manage_EKS_Cluster_policy" {
  #name = "manage_EKS_Cluster_policy_document"
  role = aws_iam_role.ebs_csi.name
  policy_arn = aws_iam_policy.custom["AmzEKSClusPol"].arn
}