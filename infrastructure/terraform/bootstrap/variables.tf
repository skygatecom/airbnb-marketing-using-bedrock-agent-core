variable "aws_region" {
  description = "AWS region for bootstrap resources."
  type        = string
}

variable "backend_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform remote state."
  type        = string
}

variable "project" {
  description = "Project name used in standard tags."
  type        = string
}

variable "environment" {
  description = "Environment name used in standard tags (for example: shared, dev, test, prod)."
  type        = string
}

variable "owner" {
  description = "Owner tag value for accountability."
  type        = string
}

variable "additional_tags" {
  description = "Additional tags merged with standard tags."
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "Whether to allow deleting the backend bucket when it contains objects."
  type        = bool
  default     = false
}

variable "sse_algorithm" {
  description = "SSE algorithm for the backend bucket encryption. Use AES256 or aws:kms."
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "sse_algorithm must be either AES256 or aws:kms."
  }
}

variable "kms_key_id" {
  description = "KMS key ID or ARN when using aws:kms encryption."
  type        = string
  default     = null

  validation {
    condition     = var.sse_algorithm != "aws:kms" || (var.kms_key_id != null && trim(var.kms_key_id) != "")
    error_message = "kms_key_id must be set when sse_algorithm is aws:kms."
  }
}
