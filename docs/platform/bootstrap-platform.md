# Bootstrap Platform Strategy

## Purpose

This document defines the bootstrap layer for infrastructure provisioning.

The bootstrap layer creates foundational resources required before regular Terraform
or Terragrunt environment stacks can run safely and consistently.

## Why a Bootstrap Layer Exists

Platform provisioning has a chicken-and-egg problem:

- Terraform and Terragrunt need remote state, locking, and execution identities.
- Those shared foundations must exist before most stacks can be applied.

The bootstrap layer solves this by provisioning platform prerequisites first,
separately from application and environment stacks.

## Scope

Bootstrap implementation lives in:

- `infrastructure/terraform/bootstrap/`

The bootstrap scope includes foundational controls such as:

- Terraform backend foundations (state and locking prerequisites)
- Execution IAM roles and policies for infrastructure automation
- Shared baseline metadata and naming standards
- Optional account-level primitives used by all environments

Bootstrap scope excludes application-specific resources and environment-specific
business services.

## Objectives

- Enable repeatable platform initialization from source control
- Standardize backend and identity foundations across environments
- Reduce manual setup steps and configuration drift
- Enforce secure defaults before broader provisioning begins
- Keep bootstrap concerns small, auditable, and easy to recover

## Architecture Model

### Layer 0: Bootstrap Foundations

Bootstrap provisions account/platform prerequisites that other stacks depend on.
This layer is intentionally minimal and highly stable.

### Layer 1: Platform Composition

After bootstrap is complete, Terragrunt composes environment stacks in:

- `infrastructure/terragrunt/dev/`
- `infrastructure/terragrunt/test/`
- `infrastructure/terragrunt/prod/`

### Layer 2: Workload Resources

Environment stacks then provision networking, security, shared, and application
resources using reusable modules.

## Bootstrap Components

Expected bootstrap component areas in `infrastructure/terraform/bootstrap/`:

- `backend/` for remote state-related primitives and conventions
- `iam/` for execution roles and least-privilege policy boundaries
- root Terraform files (`main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`,
  `versions.tf`) for bootstrap composition

At the current repository stage, these files and directories are scaffolded and will be
implemented incrementally.

## Execution Strategy

Recommended bootstrap sequence:

1. Validate Terraform configuration in bootstrap root
2. Plan bootstrap changes and review for destructive impact
3. Apply bootstrap in a controlled, auditable context
4. Verify outputs required by downstream Terragrunt workflows
5. Proceed with environment stack provisioning

Bootstrap changes should be rarer and more conservative than regular stack changes.

## Environment Strategy

- Bootstrap can be account-scoped or environment-scoped depending on isolation model.
- If using separate AWS accounts per environment, bootstrap should run per account.
- If using shared accounts, bootstrap must preserve strict naming and IAM boundaries.
- Bootstrap outputs consumed by Terragrunt must be deterministic and documented.

## Security Guardrails

- Bootstrap roles must follow least privilege.
- Sensitive values must come from approved secret-management workflows.
- No long-lived secrets should be hardcoded in bootstrap configuration.
- Changes to IAM or backend primitives require enhanced review.

## Operational Guardrails

- Bootstrap plans require explicit reviewer sign-off.
- Production bootstrap changes should require manual approval.
- Emergency bootstrap changes must be documented with follow-up remediation notes.
- Structural bootstrap changes require an ADR update.

## Failure and Recovery Philosophy

- Keep bootstrap state isolated from workload state.
- Prefer additive changes and controlled migrations over destructive replacements.
- Recovery procedures should prioritize restoring backend and IAM functionality first.

## Relationship to Other Platform Docs

- Terraform platform strategy: `docs/platform/terraform-platform.md`
- Terragrunt architecture: `docs/platform/terragrunt-architecture.md`

This bootstrap document defines prerequisites that make those workflows reliable.

## Related ADRs

- `architecture/adr/ADR-004-terraform-terragrunt-platform.txt`
- `architecture/adr/ADR-005-terragrunt-architecture.txt`
- `architecture/adr/ADR-006-bootstrap-platform.txt`
