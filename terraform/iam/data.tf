data "aws_iam_policy_document" "account-admin-policy" {
  version = "2012-10-17"
  statement {
    sid    = "AllowAllButIAM"
    effect = "Allow"
    not_actions = ["iam:*",
    "aws-portal:*"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowAllUsersToListAccounts"
    effect = "Allow"
    actions = ["iam:ListAccountAliases",
    "iam:ListUsers"]
    resources = ["arn:aws:iam::${var.account_id}/user/*"]
  }

  statement {
    sid    = "AllowUsersToViewOwnAccountInfo"
    effect = "Allow"
    actions = ["iam:ChangePassword",
      "iam:CreateLoginProfile",
      "iam:DeleteLoginProfile",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:GetLoginProfile",
    "iam:UpdateLoginProfile"]
    resources = ["arn:aws:iam::${var.account_id}/user/$${aws:username}"]
  }

  statement {
    sid    = "AllowUserToViewOwnMFA"
    effect = "Allow"
    actions = ["iam:ListVirtualMFADevices",
    "iam:ListMFADevices"]
    resources = ["arn:aws:iam::${var.account_id}/mfa/*",
    "arn:aws:iam::${var.account_id}/user/$${aws:username}"]
  }

  statement {
    sid    = "AllowIndividualUserToManageThierMFA"
    effect = "Allow"
    actions = ["iam:CreateVirtualMFADevice",
      "iam:DeactivateMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
    "iam:ResyncMFADevice"]
    resources = ["arn:aws:iam::${var.account_id}/mfa/$${aws:username}",
    "arn:aws:iam::${var.account_id}/user/$${aws:username}"]
  }

  statement {
    sid    = "DenyCloudTrailChanges"
    effect = "Deny"
    actions = ["cloudtrail:DeleteTrail",
      "cloudtrail:StopLogging",
    "cloudtrail:UpdateTrail"]
    resources = ["*"]
  }

  statement {
    sid         = "DenyAllUnlessMFAEnabled"
    effect      = "Deny"
    not_actions = ["iam:*"]
    resources   = ["*"]
    condition {
      test     = "Null"
      variable = "aws:MultiFactorAuthAge"
      values = [
        "true",
      ]
    }
  }
}

data "aws_iam_policy_document" "iam-admin-policy" {
  version = "2012-10-17"
  statement {
    sid    = "AllowAllIAM"
    effect = "Allow"
    actions = ["iam:*",
    "aws-portal:*"]
    resources = ["*"]
  }

  statement {
    sid    = "DenyAllOtherUnlessMFAEnabled"
    effect = "Deny"
    not_actions = ["iam:CreateVirtualMFADevice",
      "iam:ListVirtualMFADevices",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ListUsers",
      "iam:ChangePassword",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:GetLoginProfile",
    "iam:UpdateLoginProfile"]
    resources = ["*"]
    condition {
      test     = "Null"
      variable = "aws:MultiFactorAuthAge"
      values = [
        "true",
      ]
    }
  }
}

data "aws_iam_policy_document" "read-only-policy" {
  version = "2012-10-17"
  statement {
    sid    = "AllowAllUsersToListAccounts"
    effect = "Allow"
    actions = ["iam:ListAccountAliases",
    "iam:ListUsers"]
    resources = ["arn:aws:iam::${var.account_id}/user/*"]
  }

  statement {
    sid    = "AllowUsersToViewOwnAccountInfo"
    effect = "Allow"
    actions = ["iam:ChangePassword",
      "iam:CreateLoginProfile",
      "iam:DeleteLoginProfile",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:GetLoginProfile",
    "iam:UpdateLoginProfile"]
    resources = ["arn:aws:iam::${var.account_id}/user/$${aws:username}"]
  }

  statement {
    sid    = "AllowUserToViewOwnMFA"
    effect = "Allow"
    actions = ["iam:ListVirtualMFADevices",
    "iam:ListMFADevices"]
    resources = ["arn:aws:iam::${var.account_id}/mfa/*",
    "arn:aws:iam::${var.account_id}/user/$${aws:username}"]
  }

  statement {
    sid    = "AllowIndividualUserToManageThierMFA"
    effect = "Allow"
    actions = ["iam:CreateVirtualMFADevice",
      "iam:DeactivateMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
    "iam:ResyncMFADevice"]
    resources = ["arn:aws:iam::${var.account_id}/mfa/$${aws:username}",
    "arn:aws:iam::${var.account_id}/user/$${aws:username}"]
  }

  statement {
    sid    = "DenyAllOtherUnlessMFAEnabled"
    effect = "Deny"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeactivateMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:ListVirtualMFADevices",
      "iam:ListMFADevices",
      "iam:ChangePassword",
      "iam:CreateLoginProfile",
      "iam:DeleteLoginProfile",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:GetLoginProfile",
      "iam:UpdateLoginProfile",
      "iam:ListAccountAliases",
      "iam:ListUsers"
    ]
    resources = ["*"]
    condition {
      test     = "Null"
      variable = "aws:MultiFactorAuthAge"
      values = [
        "true",
      ]
    }
  }
}
