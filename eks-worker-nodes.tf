resource "aws_eks_node_group" "group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.cluster_name
  node_role_arn   = module.node_group_iam_role.role_arn
  subnet_ids      = aws_subnet.private[*].id
  instance_types  = var.instance_types

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    "Name" = var.cluster_name
  }

  depends_on = [
    module.node_group_iam_role
  ]

  tags = {
    Name = var.cluster_name
  }
}
