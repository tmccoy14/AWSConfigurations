terraform {
  required_version = ">= 0.12.19"
}

# ---------------------------------------------------------------------------------------------------------------------
# PREPARE PROVIDERS
# ---------------------------------------------------------------------------------------------------------------------
provider "aws" {
  version = "~> 3.0"
  region  = "us-east-2"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE ACCOUNT ADMIN IAM GROUP, IAM POLICY, IAM GROUP POLICY ATTACHMENT
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_group" "account-admin-group" {
  name = "account-admin-group"
  path = "/"
}

resource "aws_iam_policy" "account-admin-policy" {
  name        = "account-admin-policy"
  path        = "/"
  description = "IAM policy for account admins."

  policy = data.aws_iam_policy_document.account-admin-policy
}

resource "aws_iam_group_policy_attachment" "account-admin-attachment" {
  group      = aws_iam_group.account-admin-group.name
  policy_arn = aws_iam_policy.account-admin-policy.arn
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE IAM ADMIN IAM GROUP, IAM POLICY, IAM GROUP POLICY ATTACHMENT
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_group" "iam-admin-group" {
  name = "iam-admin-group"
  path = "/"
}

resource "aws_iam_policy" "iam-admin-policy" {
  name        = "iam-admin-policy"
  path        = "/"
  description = "IAM policy for IAM admins."

  policy = data.aws_iam_policy_document.iam-admin-policy
}

resource "aws_iam_group_policy_attachment" "iam-admin-attachment" {
  group      = aws_iam_group.iam-admin-group.name
  policy_arn = aws_iam_policy.iam-admin-policy.arn
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE READ ONLY IAM GROUP, IAM POLICY, IAM GROUP POLICY ATTACHMENT
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_group" "read-only-group" {
  name = "read-only-group"
  path = "/"
}

resource "aws_iam_policy" "read-only-policy" {
  name        = "read-only-policy"
  path        = "/"
  description = "IAM policy for read only users."

  policy = data.aws_iam_policy_document.read-only-policy
}

resource "aws_iam_group_policy_attachment" "read-only-attachment" {
  group      = aws_iam_group.read-only-group.name
  policy_arn = aws_iam_policy.read-only-policy.arn
}
