# Terraform Backend Platform

## Purpose

This document defines the remote backend strategy for Terraform state in this
repository.

It describes how backend resources are provisioned, what security controls are applied,
and how platform teams should consume backend outputs safely.

## Scope

Backend resources are provisioned by the bootstrap backend module:

- infrastructure/terraform/bootstrap/backend/

Root bootstrap wiring is in:

- infrastructure/terraform/bootstrap/main.tf

This strategy currently covers the S3 backend bucket foundations for remote state.

## Objectives

- Provide a centralized and durable location for Terraform state
- Protect state integrity with versioning and encryption
- Block unintended public exposure by default
- Standardize backend tagging and ownership metadata
- Keep backend setup reproducible through Terraform code

## Current Implementation

The backend module provisions an S3 bucket with:

- Versioning enabled
- Server-side encryption enabled
- Public access block enforced
- Standard tags merged with optional additional tags

The module supports encryption modes:

- AES256 (default)
- aws:kms (with required kms_key_id)

## Security Controls

### Data Protection

- Bucket-level server-side encryption is always enabled.
- Versioning is enabled to improve recoverability and auditability.

### Public Exposure Prevention

The backend bucket enforces all S3 public access block settings:

- block_public_acls = true
- block_public_policy = true
- ignore_public_acls = true
- restrict_public_buckets = true

### Ownership and Traceability

Standard tags are applied:

- Project
- Environment
- Owner
- ManagedBy = terraform
- Component = terraform-backend

Additional tags can be merged to satisfy organization-specific controls.

## Module Interface

### Required Inputs

- bucket_name
- project
- environment
- owner

### Optional Inputs

- additional_tags (default: {})
- force_destroy (default: false)
- sse_algorithm (default: AES256)
- kms_key_id (required only when sse_algorithm = aws:kms)

### Outputs

- bucket_id
- bucket_arn
- bucket_region
- tags

## Root Bootstrap Contract

The bootstrap root module maps backend configuration through:

- backend_bucket_name
- project
- environment
- owner
- additional_tags
- force_destroy
- sse_algorithm
- kms_key_id

And exposes backend outputs for downstream consumers:

- backend_bucket_id
- backend_bucket_arn
- backend_bucket_region
- backend_bucket_tags

## Operational Guidance

- Keep force_destroy set to false for shared or production-like backends.
- Use aws:kms for environments requiring customer-managed encryption keys.
- Review plan output carefully before backend changes.
- Treat backend changes as high-impact platform changes.

## Known Gaps and Next Hardening Step

Current backend implementation does not yet include a locking table.

Recommended next step:

- Add a DynamoDB locking table module for Terraform state lock coordination.

## Relationship to Other Platform Docs

- docs/platform/bootstrap-platform.md
- docs/platform/terraform-platform.md
- docs/platform/terragrunt-architecture.md

## Related ADRs

- architecture/adr/ADR-004-terraform-terragrunt-platform.txt
- architecture/adr/ADR-006-bootstrap-platform.txt
- architecture/adr/ADR-007-terraform-backend.txt
