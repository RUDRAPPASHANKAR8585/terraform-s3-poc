locals {

  tags = merge(
    {
      Name        = var.bucket_name
      Environment = var.environment
      Project     = var.project
      Application = var.application
      Owner       = var.owner
      CostCenter  = var.cost_center
      Terraform   = "true"
      ManagedBy   = "Terraform"
    },
    var.additional_tags
  )

}