# ####################################
# # General
# ####################################

# variable "bucket_name" {
#   description = "Name of the S3 bucket."
#   type        = string

#   validation {
#     condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
#     error_message = "Bucket name must be between 3 and 63 characters."
#   }
# }

# variable "bucket_prefix" {
#   description = "Prefix for bucket name if bucket_name is not specified."
#   type        = string
#   default     = null
# }

# variable "bucket_namespace" {
#   description = "Bucket namespace."
#   type        = string
#   default     = "global"

#   validation {
#     condition = contains([
#       "global",
#       "account-regional"
#     ], var.bucket_namespace)

#     error_message = "Allowed values are global or account-regional."
#   }
# }

# variable "force_destroy" {
#   description = "Delete all objects before destroying bucket."
#   type        = bool
#   default     = false
# }

# variable "object_lock_enabled" {
#   description = "Enable S3 Object Lock."
#   type        = bool
#   default     = false
# }

# ################ Versioning ##########################################

# variable "versioning_status" {
#   description = "Versioning status."
#   type        = string
#   default     = "Enabled"

#   validation {
#     condition = contains([
#       "Enabled",
#       "Suspended"
#     ], var.versioning_status)

#     error_message = "Must be Enabled or Suspended."
#   }
# }

# variable "mfa_delete" {
#   description = "Enable MFA Delete."
#   type        = string
#   default     = "Disabled"
# }

# ####################### KMS ##############################################

# variable "sse_algorithm" {
#   description = "Default server-side encryption algorithm."
#   type        = string
#   default     = "AES256"

#   validation {
#     condition = contains([
#       "AES256",
#       "aws:kms"
#     ], var.sse_algorithm)

#     error_message = "Allowed values are AES256 or aws:kms."
#   }
# }

# variable "kms_key_id" {
#   description = "KMS Key ARN."
#   type        = string
#   default     = null
# }

# variable "bucket_key_enabled" {
#   description = "Enable Bucket Keys."
#   type        = bool
#   default     = true
# }

# ##################### Public Access ########################################

# variable "block_public_acls" {
#   type    = bool
#   default = true
# }

# variable "ignore_public_acls" {
#   type    = bool
#   default = true
# }

# variable "block_public_policy" {
#   type    = bool
#   default = true
# }

# variable "restrict_public_buckets" {
#   type    = bool
#   default = true
# }

# ########################## Ownership ######################################

# variable "object_ownership" {
#   description = "S3 Object Ownership."

#   type = string

#   default = "BucketOwnerEnforced"

#   validation {

#     condition = contains([
#       "BucketOwnerPreferred",
#       "ObjectWriter",
#       "BucketOwnerEnforced"
#     ], var.object_ownership)

#     error_message = "Invalid ownership type."
#   }
# }

# ########################### Logging ########################################

# variable "enable_logging" {
#   type    = bool
#   default = false
# }

# variable "logging_bucket" {
#   type    = string
#   default = null
# }

# variable "logging_prefix" {
#   type    = string
#   default = null
# }

# ############################# website ######################################

# variable "enable_static_website" {
#   type    = bool
#   default = false
# }

# variable "index_document" {
#   type    = string
#   default = "index.html"
# }

# variable "error_document" {
#   type    = string
#   default = "error.html"
# }

# ################################# CORS #######################################

# variable "cors_rules" {

#   description = "CORS rules."

#   type = list(object({

#     allowed_headers = optional(list(string), [])

#     allowed_methods = list(string)

#     allowed_origins = list(string)

#     expose_headers = optional(list(string), [])

#     max_age_seconds = optional(number)

#   }))

#   default = []
# }

# ############################## Lifecycle Rules ###################################

# variable "lifecycle_rules" {

#   type = list(object({

#     id = string

#     status = string

#     filter_prefix = optional(string)

#     transition = optional(list(object({

#       days = number

#       storage_class = string

#     })))

#     expiration_days = optional(number)

#     noncurrent_version_transition = optional(list(object({

#       noncurrent_days = number

#       storage_class = string

#     })))

#     noncurrent_version_expiration_days = optional(number)

#     abort_incomplete_multipart_upload_days = optional(number)

#   }))

#   default = []

# }

# ####################################  Tags ##########################################

# variable "environment" {
#   type = string
# }

# variable "project" {
#   type = string
# }

# variable "application" {
#   type = string
# }

# variable "owner" {
#   type = string
# }

# variable "cost_center" {
#   type = string
# }

# variable "additional_tags" {
#   type    = map(string)
#   default = {}
# }

# ####################################
# # Replication
# ####################################

# variable "enable_replication" {
#   description = "Enable S3 replication."
#   type        = bool
#   default     = false
# }

# variable "replication_role_arn" {
#   description = "IAM Role ARN used for replication."
#   type        = string
#   default     = null
# }

# variable "destination_bucket_arn" {
#   description = "Destination bucket ARN."
#   type        = string
#   default     = null
# }

# variable "replica_kms_key_id" {
#   description = "KMS key ARN for replicated objects."
#   type        = string
#   default     = null
# }

# ####################################
# # Object Lock
# ####################################

# variable "object_lock_mode" {

#   type    = string
#   default = "GOVERNANCE"

#   validation {

#     condition = contains([
#       "GOVERNANCE",
#       "COMPLIANCE"
#     ], var.object_lock_mode)

#     error_message = "Mode must be GOVERNANCE or COMPLIANCE."

#   }

# }

# variable "object_lock_days" {

#   type    = number
#   default = null

# }

# variable "object_lock_years" {

#   type    = number
#   default = null

# }

# ####################################
# # Transfer Acceleration
# ####################################

# variable "enable_transfer_acceleration" {

#   type    = bool
#   default = false

# }

# ####################################
# # Request Payer
# ####################################

# variable "request_payer" {

#   type    = string
#   default = "BucketOwner"

# }

# ####################################
# # Bucket Policy
# ####################################

# variable "attach_bucket_policy" {

#   type    = bool
#   default = false

# }

# variable "bucket_policy" {

#   description = "JSON bucket policy."

#   type = string

#   default = null

# }

# ####################################
# # Security
# ####################################

# variable "enforce_ssl_requests_only" {

#   description = "Deny HTTP access."

#   type = bool

#   default = true

# }

# variable "expected_bucket_owner" {

#   description = "Expected AWS Account ID."

#   type = string

#   default = null

# }

# ####################################
# # Inventory
# ####################################

# variable "enable_inventory" {

#   type    = bool
#   default = false

# }

# variable "inventory_destination_bucket" {

#   type    = string
#   default = null

# }

# ####################################
# # Analytics
# ####################################

# variable "enable_analytics" {

#   type    = bool
#   default = false

# }

# ####################################
# # Notifications
# ####################################

# variable "enable_event_notifications" {

#   type    = bool
#   default = false

# }

# variable "lambda_notifications" {

#   description = "Lambda notification configuration."

#   type = list(object({

#     lambda_function_arn = string

#     events = list(string)

#     filter_prefix = optional(string)

#     filter_suffix = optional(string)

#   }))

#   default = []

# }

# ####################################
# # Metrics
# ####################################

# variable "enable_metrics" {

#   type    = bool
#   default = false

# }

# ####################################
# # CloudTrail Logging
# ####################################

# variable "enable_cloudtrail_logging" {

#   type    = bool
#   default = false

# }

# ####################################
# # Access Point
# ####################################

# variable "create_access_point" {

#   type    = bool
#   default = false

# }

# variable "access_point_name" {

#   type    = string
#   default = null

# }

# ####################################
# # Intelligent Tiering
# ####################################

# variable "enable_intelligent_tiering" {

#   type    = bool
#   default = false 

# }

# variable "attach_custom_policy" {
#   description = "Attach custom bucket policy."
#   type        = bool
#   default     = false
# }

# variable "custom_policy_json" {
#   description = "Custom bucket policy JSON."
#   type        = string
#   default     = null
# }
