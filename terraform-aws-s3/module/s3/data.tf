data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ssl_only" {

  statement {

    sid = "AllowSSLRequestsOnly"

    effect = "Deny"

    principals {

      type = "*"

      identifiers = ["*"]

    }

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:${data.aws_partition.current.partition}:s3:::${var.bucket_name}",
      "arn:${data.aws_partition.current.partition}:s3:::${var.bucket_name}/*"
    ]

    condition {

      test = "Bool"

      variable = "aws:SecureTransport"

      values = [
        "false"
      ]

    }

  }

}

data "aws_iam_policy_document" "combined" {

  source_policy_documents = compact([
    var.enforce_ssl_requests_only ? data.aws_iam_policy_document.ssl_only.json : "",
    var.attach_custom_policy ? var.custom_policy_json : ""
  ])
}