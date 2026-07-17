output "backend_bucket_id" {
  description = "The backend S3 bucket name/id."
  value       = module.backend.bucket_id
}

output "backend_bucket_arn" {
  description = "The backend S3 bucket ARN."
  value       = module.backend.bucket_arn
}

output "backend_bucket_region" {
  description = "AWS region where the backend S3 bucket is provisioned."
  value       = module.backend.bucket_region
}

output "backend_bucket_tags" {
  description = "Effective tags applied to the backend S3 bucket."
  value       = module.backend.tags
}
