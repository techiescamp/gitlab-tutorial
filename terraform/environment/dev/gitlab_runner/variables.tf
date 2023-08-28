variable "instance_profile_name" {
  type    = string
  default = "gitlab-runner-instance-profile"
}

variable "iam_policy_name" {
  type    = string
  default = "gitlab-runner-policy"
}

variable "role_name" {
  type    = string
  default = "gitlab-runner-role"
}