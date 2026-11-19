# Dynamically Fetch Cluster Name Format
locals {
  cluster_name = "Pathnex-${formatdate("MMM-YYYY", timestamp())}"
}