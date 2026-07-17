variable "bucket_name" {
  description = "Globally unique S3 bucket name for Terraform remote state."
  type        = string
}

variable "project" {
  description = "Project name used in standard tags."
  type        = string
}

variable "environment" {
  description = "Environment name (for example: dev, test, prod) used in standard tags."
  type        = string
}

variable "owner" {
  description = "Owner tag value for accountability."
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to merge with standard tags."
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "Whether to allow deleting the bucket even when it contains objects."
  type        = bool
  default     = false
}

variable "sse_algorithm" {
  description = "SSE algorithm for bucket encryption. Use AES256 or aws:kms."
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "sse_algorithm must be either AES256 or aws:kms."
  }
}

variable "kms_key_id" {
  description = "KMS key ID or ARN for SSE-KMS. Required when sse_algorithm is aws:kms."
  type        = string
  default     = null

  validation {
    condition     = var.sse_algorithm != "aws:kms" || (var.kms_key_id != null && trim(var.kms_key_id) != "")
    error_message = "kms_key_id must be set when sse_algorithm is aws:kms."
  }
}
