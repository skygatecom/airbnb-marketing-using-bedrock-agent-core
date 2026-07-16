output "bucket_id" {
  description = "The name/id of the backend S3 bucket."
  value       = aws_s3_bucket.backend.id
}

output "bucket_arn" {
  description = "The ARN of the backend S3 bucket."
  value       = aws_s3_bucket.backend.arn
}

output "bucket_region" {
  description = "The AWS region where the backend S3 bucket is deployed."
  value       = data.aws_region.current.region
}

output "tags" {
  description = "Effective tags applied to the backend bucket."
  value       = aws_s3_bucket.backend.tags
}
