variable "role_name" {
  type = string
}

variable "assume_role_policy" {
  type = string
}

variable "iam_role_description" {
  type    = string
  default = null
}

variable "policy_names" {
  type    = list(string)
  default = []
}
