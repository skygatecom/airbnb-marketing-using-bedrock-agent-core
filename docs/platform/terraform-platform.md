# Terraform Platform Strategy

## Purpose

This document describes why the platform uses Terraform and Terragrunt, what the
platform is trying to achieve, and how environments are structured for safe delivery.

## Why Terraform Was Chosen

Terraform is the primary infrastructure-as-code engine for this project because it
provides:

- Declarative infrastructure with predictable plans before apply
- A mature AWS provider ecosystem
- Strong module patterns for reusable infrastructure building blocks
- Clear state and drift detection workflows
- Large community support and broad hiring familiarity

For a production-style learning and reference repository, Terraform gives a practical
balance of readability, ecosystem maturity, and operational discipline.

## Why Terragrunt Was Added

Terragrunt is used as an orchestration and structure layer on top of Terraform.

Terraform solves resource provisioning, but Terragrunt helps standardize how multiple
environments and modules are composed.

Terragrunt was added to provide:

- DRY configuration via shared settings and inheritance
- Consistent remote state/back-end configuration across environments
- Dependency wiring between infrastructure stacks
- Better multi-environment execution ergonomics
- Reduced copy-paste for repeated environment layouts

In short:

- Terraform is the provisioning engine.
- Terragrunt is the environment and workflow coordinator.

## Platform Objectives

The platform implementation is designed to support the project goals while remaining
operable by a small team.

Primary objectives:

- Reproducible infrastructure from source control
- Safe changes with plan-first workflows
- Clear environment isolation (dev, test, prod)
- Least-privilege and auditable cloud access
- Reusable modules for common AWS patterns
- Fast onboarding for contributors
- Cost-aware defaults for non-production environments

Secondary objectives:

- Support incremental adoption as modules evolve
- Keep architecture understandable for learning and portfolio use
- Enable future CI/CD automation with minimal restructuring

## Environment Strategy

### Environment Model

Use separate logical environments at minimum:

- `dev` for active development and experimentation
- `test` (or `staging`) for validation and integration checks
- `prod` for stable production workloads

Where feasible, isolate by separate AWS accounts per environment.
If account-per-environment is not yet available, enforce strict naming, tagging,
state separation, and IAM boundaries.

### State and Isolation

- Each environment must have isolated Terraform state.
- State backends should be remote, locked, and encrypted.
- Never share a state file across environments.

### Configuration Rules

- Keep module logic generic and environment-agnostic.
- Put environment-specific values in Terragrunt environment configuration.
- Do not hardcode secrets or account-specific identifiers in reusable modules.

### Promotion Approach

Promote infrastructure changes progressively:

1. Validate in `dev`
2. Re-validate in `test`/`staging`
3. Promote to `prod` after review and approval

Production applies should require explicit human approval.

### Operational Guardrails

- Plan output must be reviewed before apply.
- Destructive changes require explicit review.
- Tag all resources with environment, owner, and cost metadata.
- Keep IAM permissions minimal for Terraform/Terragrunt execution roles.

## Working Conventions

- Keep reusable Terraform modules in `infrastructure/terraform/`.
- Keep environment orchestration and stack composition in
  `infrastructure/terragrunt/`.
- Document major platform design changes in ADRs.

## Summary

Terraform was chosen for robust, declarative AWS provisioning.
Terragrunt was added to scale that provisioning model cleanly across environments.
Together they support a platform that is reproducible, secure, and maintainable while
remaining practical for contributors and future automation.

## Related ADR

- `architecture/adr/ADR-004-terraform-terragrunt-platform.txt`
