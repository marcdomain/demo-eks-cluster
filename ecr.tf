module "ecr_repositories" {
  source               = "./modules/ecr"
  ecr_repo_names       = local.service_names
  ecr_lifecycle_policy = file("./policy-doc/ecr-lifecycle-policy.json")
}
