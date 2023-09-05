output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "reverse_ip_service_account" {
  value = module.reverse_ip_service_account.service_account_arn
}

output "autoscaler_service_account" {
  value = module.cluster_autoscaler_service_account.service_account_arn
}

output "ecr_repositories" {
  value = module.ecr_repositories.ecr_repositories
}
