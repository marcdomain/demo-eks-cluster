variable "ecr_repo_names" {
  type    = list(string)
  default = []
}

variable "image_tag_mutability" {
  type    = string
  default = "MUTABLE"
}

variable "ecr_lifecycle_policy" {
  type = string
}
