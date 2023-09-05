output "ecr_repositories" {
  value = [ for repo in aws_ecr_repository.ecr : repo.arn ]
}
