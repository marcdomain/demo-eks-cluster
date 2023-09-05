resource "aws_iam_role" "main" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
  description        = var.iam_role_description
  tags = {
    Name = var.role_name
  }
}

data "aws_iam_policy" "main" {
  for_each = { for name in var.policy_names : name => name }
  name     = each.key
}

resource "aws_iam_role_policy_attachment" "main" {
  for_each   = { for name in values(data.aws_iam_policy.main)[*].arn : name => name }
  role       = aws_iam_role.main.name
  policy_arn = each.key
}
