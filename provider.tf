provider "aws" {
  region  = var.region
  profile = "self"

  default_tags {
    tags = local.tags
  }
}
