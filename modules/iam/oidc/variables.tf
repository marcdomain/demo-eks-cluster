variable "oidc_provider_arns" {
  type = list(string)
}

variable "service_account" {
  type = list(string)
}

variable "oidc_provider_url" {
  type = string
}

variable "role_name" {
  type = string
}

variable "iam_policy" {
  type = string
}
