resource "aws_security_group" "cluster" {
  name        = var.cluster_name
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.cluster_name
  }
}

# resource "aws_security_group_rule" "cluster-ingress-workstation-https" {
#   cidr_blocks       = [local.workstation-external-cidr]
#   description       = "Allow workstation to communicate with the cluster API Server"
#   from_port         = 443
#   protocol          = "tcp"
#   security_group_id = aws_security_group.cluster.id
#   to_port           = 443
#   type              = "ingress"
# }

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = module.cluster_iam_role.role_arn

  vpc_config {
    security_group_ids = [aws_security_group.cluster.id]
    subnet_ids         = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)
  }

  depends_on = [
    module.cluster_iam_role
  ]
}
