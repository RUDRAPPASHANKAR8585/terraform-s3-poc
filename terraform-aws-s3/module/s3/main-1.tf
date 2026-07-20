# ###############################################################
# # S3 Bucket
# ###############################################################

# resource "aws_s3_bucket" "this" {

#   bucket           = var.bucket_name
#   bucket_prefix    = var.bucket_prefix
#   bucket_namespace = var.bucket_namespace

#   force_destroy = var.force_destroy

#   object_lock_enabled = var.object_lock_enabled

#   # expected_bucket_owner = var.expected_bucket_owner

#   timeouts {
#     create = "30m"
#     update = "30m"
#     delete = "60m"
#   }

#   tags = local.tags

# }

# ###############################################################
# # Ownership Controls
# ###############################################################

# resource "aws_s3_bucket_ownership_controls" "this" {

#   bucket = aws_s3_bucket.this.id

#   rule {

#     object_ownership = var.object_ownership

#   }

# }

# ###############################################################
# # Public Access Block
# ###############################################################

# resource "aws_s3_bucket_public_access_block" "this" {

#   bucket = aws_s3_bucket.this.id

#   block_public_acls = var.block_public_acls

#   ignore_public_acls = var.ignore_public_acls

#   block_public_policy = var.block_public_policy

#   restrict_public_buckets = var.restrict_public_buckets

# }

# ###############################################################
# # Versioning
# ###############################################################

# resource "aws_s3_bucket_versioning" "this" {

#   bucket = aws_s3_bucket.this.id

#   versioning_configuration {

#     status = var.versioning_status

#     mfa_delete = var.mfa_delete

#   }

# }

# ###############################################################
# # Default Encryption
# ###############################################################

# resource "aws_s3_bucket_server_side_encryption_configuration" "this" {

#   bucket = aws_s3_bucket.this.id

#   lifecycle {
#     precondition {
#       condition = (
#         var.sse_algorithm == "AES256" ||
#         (
#           var.sse_algorithm == "aws:kms" &&
#           var.kms_key_id != null
#         )
#       )

#       error_message = "kms_key_id must be provided when sse_algorithm is aws:kms."
#     }
#   }

#   rule {

#     bucket_key_enabled = var.bucket_key_enabled

#     apply_server_side_encryption_by_default {

#       sse_algorithm = var.sse_algorithm

#       kms_master_key_id = (
#         var.sse_algorithm == "aws:kms"
#         ? var.kms_key_id
#         : null
#       )
#     }
#   }
# }




# ###############################################################
# # Transfer Acceleration
# ###############################################################

# resource "aws_s3_bucket_accelerate_configuration" "this" {

#   count = var.enable_transfer_acceleration ? 1 : 0

#   bucket = aws_s3_bucket.this.id

#   status = "Enabled"

# }

# ###############################################################
# # Request Payment Configuration
# ###############################################################

# resource "aws_s3_bucket_request_payment_configuration" "this" {

#   bucket = aws_s3_bucket.this.id

#   payer = var.request_payer

# }

# ###############################################################
# # Bucket Logging
# ###############################################################

# resource "aws_s3_bucket_logging" "this" {

#   count = var.enable_logging ? 1 : 0

#   bucket = aws_s3_bucket.this.id

#   target_bucket = var.logging_bucket

#   target_prefix = var.logging_prefix

# }

# ###############################################################
# # Bucket Policy
# ###############################################################
# resource "aws_s3_bucket_policy" "this" {

#   count = (
#     var.enforce_ssl_requests_only ||
#     var.attach_custom_policy
#   ) ? 1 : 0

#   bucket = aws_s3_bucket.this.id

#   policy = data.aws_iam_policy_document.combined.json
# }


# ###############################################################
# # Lifecycle Configuration
# ###############################################################

# resource "aws_s3_bucket_lifecycle_configuration" "this" {

#   count = length(var.lifecycle_rules) > 0 ? 1 : 0

#   bucket = aws_s3_bucket.this.id

#   dynamic "rule" {

#     for_each = var.lifecycle_rules

#     content {

#       id     = rule.value.id
#       status = rule.value.status

#       filter {

#         prefix = try(rule.value.filter_prefix, null)

#       }

#       dynamic "transition" {

#         for_each = try(rule.value.transition, null) == null ? [] : [rule.value.transition]

#         content {

#           days          = transition.value.days
#           storage_class = transition.value.storage_class

#         }

#       }

#       dynamic "expiration" {

#         for_each = try(rule.value.expiration_days, null) == null ? [] : [rule.value.expiration_days]

#         content {

#           days = expiration.value

#         }

#       }

#     }

#   }

# }

# ###############################################################
# # CORS Configuration
# ###############################################################

# resource "aws_s3_bucket_cors_configuration" "this" {

#   count = length(var.cors_rules) > 0 ? 1 : 0

#   bucket = aws_s3_bucket.this.id

#   dynamic "cors_rule" {

#     for_each = var.cors_rules

#     content {

#       allowed_headers = try(cors_rule.value.allowed_headers, [])

#       allowed_methods = cors_rule.value.allowed_methods

#       allowed_origins = cors_rule.value.allowed_origins

#       expose_headers = try(cors_rule.value.expose_headers, [])

#       max_age_seconds = try(cors_rule.value.max_age_seconds, null)

#     }

#   }

# }

# ###############################################################
# # Website Configuration
# ###############################################################

# resource "aws_s3_bucket_website_configuration" "this" {

#   count = var.enable_static_website ? 1 : 0

#   bucket = aws_s3_bucket.this.id

#   index_document {

#     suffix = var.index_document

#   }

#   error_document {

#     key = var.error_document

#   }

# }

# ###############################################################
# # Object Lock Configuration
# ###############################################################

# resource "aws_s3_bucket_object_lock_configuration" "this" {

#   count = var.object_lock_enabled ? 1 : 0

#   bucket = aws_s3_bucket.this.id

#   rule {

#     default_retention {

#       mode = var.object_lock_mode

#       days = var.object_lock_days

#       years = var.object_lock_years

#     }

#   }

#   depends_on = [

#     aws_s3_bucket_versioning.this

#   ]

# }

# ###############################################################
# # Replication Configuration
# ###############################################################

# resource "aws_s3_bucket_replication_configuration" "this" {

#   count = var.enable_replication ? 1 : 0

#   bucket = aws_s3_bucket.this.id

#   role = var.replication_role_arn

#   rule {

#     id = "replication-rule"

#     status = "Enabled"

#     delete_marker_replication {
#       status = "Enabled"
#     }

#     filter {}

#     destination {

#       bucket = var.destination_bucket_arn

#       storage_class = "STANDARD"

#       #replica_kms_key_id = var.replica_kms_key_id

#     }

#   }

#   depends_on = [
#     aws_s3_bucket_versioning.this
#   ]
# }