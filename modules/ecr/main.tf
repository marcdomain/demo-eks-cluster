resource "aws_ecr_repository" "ecr" {
  for_each             = { for name in var.ecr_repo_names : name => name }
  name                 = each.value
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = merge(
    {
      "Name" : "${each.value}"
    }
  )
}

resource "aws_ecr_lifecycle_policy" "ecr-lifecycle" {
  for_each   = { for name in var.ecr_repo_names : name => name }
  repository = aws_ecr_repository.ecr[each.key].name
  policy     = var.ecr_lifecycle_policy
}
