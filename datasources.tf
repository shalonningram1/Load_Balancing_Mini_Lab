data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*.0-x86_64-gp2"]
  }
}

data "aws_iam_policy_document" "public_objects" {
    statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = ["arn:aws:s3:::site-files-shalonn",
                 "arn:aws:s3:::site-files-shalonn/*"]
  }
}

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  