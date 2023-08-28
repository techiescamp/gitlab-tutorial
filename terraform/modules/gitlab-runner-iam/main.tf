# Create an IAM policy
resource "aws_iam_policy" "gitlab_runner_iam_policy" {
  name = var.iam_policy_name
  description = "Allow GitLab Runner to push images to ECR"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:*",
          "ecr-public:*",
          "sts:GetServiceBearerToken"  
        ],
        Resource = "*"
      }
    ]
  })
}

# Create an IAM role
resource "aws_iam_role" "gitlab_runner_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_policy_attachment" "gitlab_runner_policy_attachment" {
  name = "Policy Attachement"
  policy_arn = aws_iam_policy.gitlab_runner_iam_policy.arn
  roles       = [aws_iam_role.gitlab_runner_role.name]
}

# Create an IAM instance profile
resource "aws_iam_instance_profile" "gitlab_runner_instance_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.gitlab_runner_role.name
}