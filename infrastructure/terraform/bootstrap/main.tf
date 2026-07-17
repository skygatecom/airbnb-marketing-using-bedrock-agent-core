module "backend" {
  source = "./backend"

  bucket_name     = var.backend_bucket_name
  project         = var.project
  environment     = var.environment
  owner           = var.owner
  additional_tags = var.additional_tags
  force_destroy   = var.force_destroy
  sse_algorithm   = var.sse_algorithm
  kms_key_id      = var.kms_key_id
}