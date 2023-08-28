provider "aws" {
  region = "us-west-2"
}

module "gitlab-runner-iam" {
  source = "../../../modules/gitlab-runner-iam"
  instance_profile_name = var.instance_profile_name
  iam_policy_name       = var.iam_policy_name
  role_name             = var.role_name
}