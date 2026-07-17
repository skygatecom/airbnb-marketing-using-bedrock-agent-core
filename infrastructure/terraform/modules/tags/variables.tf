variable "project" {
  description = "Project name used in standard tags."
  type        = string
  validation {
    condition     = length(trim(var.project, " ")) > 0
    error_message = "The project name must not be empty."
  }
}

variable "environment" {
  description = "Environment name used in standard tags (for example: shared, dev, test, prod)."
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "The environment name must be dev, test or prod."
  }
}

variable "owner" {
  description = "Owner tag value for accountability."
  type        = string
  validation {
    condition     = length(trim(var.owner, " ")) > 0
    error_message = "The owner name must not be empty."
  }
}