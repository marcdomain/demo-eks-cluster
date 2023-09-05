terraform {
  backend "s3" {
    bucket         = "marcus-eks-infra"
    key            = "eks.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "marcus-eks-infra-state-lock"
    profile        = "self"
  }
}
