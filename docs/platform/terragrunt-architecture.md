# Terragrunt Architecture

## Purpose

This document defines how Terragrunt structures Terraform execution across
environments in this repository.

The architecture is designed to keep module usage consistent, reduce configuration
duplication, and make promotions from dev to test to prod safer.

## Design Principles

- Keep Terraform modules reusable and environment-agnostic.
- Keep environment-specific concerns in Terragrunt configuration.
- Prefer explicit dependency wiring over hidden implicit ordering.
- Use plan-first workflows and controlled apply operations.
- Enforce environment isolation through state, naming, and IAM boundaries.

## Repository Layout

Terragrunt orchestration is organized under:

- `infrastructure/terragrunt/terragrunt.hcl` as root shared configuration
- `infrastructure/terragrunt/dev/` for development stacks
- `infrastructure/terragrunt/test/` for pre-production validation stacks
- `infrastructure/terragrunt/prod/` for production stacks

Current domain stack folders under `dev/` include:

- `networking/`
- `security/`
- `shared/`
- `application/`

The same domain stack pattern should be mirrored in `test/` and `prod/` unless a
stack is intentionally environment-specific.

## Configuration Hierarchy

Terragrunt configuration is layered to separate global defaults from environment and
stack details.

### Layer 1: Root Configuration

The root `terragrunt.hcl` defines organization-wide conventions, such as:

- Remote state backend defaults
- Shared provider settings
- Global input defaults
- Common tags and metadata

### Layer 2: Environment Configuration

Each environment directory defines environment-level settings, such as:

- Environment identifier
- AWS account and region mapping
- Environment-wide tags and naming prefixes
- Shared dependency references

### Layer 3: Stack Configuration

Each stack (for example networking or application) defines:

- The source Terraform module
- Stack-specific input values
- Dependency blocks to upstream stacks
- Output usage from dependencies

## Dependency Model

Dependencies should follow a clear order that minimizes cycles:

1. `networking`
2. `security`
3. `shared`
4. `application`

Rules:

- Lower-level foundations must not depend on higher-level application stacks.
- Cross-stack references should flow through declared Terragrunt dependencies.
- Circular dependencies are not permitted.

## State Architecture

- Every environment-stack unit must have its own isolated state path.
- Remote state must be encrypted and support locking.
- State keys should be deterministic and include environment plus stack identity.
- Direct state manipulation should be avoided except for controlled recovery.

## Execution Model

Terragrunt is the primary interface for module planning and applying.

Recommended workflow:

1. Run format and validation checks in the target stack or environment.
2. Run plan and review output before apply.
3. Apply in `dev` first.
4. Promote same logical change to `test` then `prod`.

Production applies should require explicit reviewer approval and change traceability.

## Security and Access Boundaries

- Execution roles should follow least privilege.
- Environment credentials must remain isolated.
- Secrets and sensitive values should be sourced from approved secret stores.
- No secret values should be hardcoded in Terragrunt inputs.

## Change Management

- Structural changes to this architecture require an ADR update.
- New stacks should include clear ownership and dependency definitions.
- Breaking layout changes should be introduced incrementally and documented.

## Summary

Terragrunt provides the composition layer that turns reusable Terraform modules into
consistent, environment-aware infrastructure stacks.

This architecture keeps environments isolated, dependencies explicit, and delivery
workflows predictable.

## Related ADRs

- `architecture/adr/ADR-004-terraform-terragrunt-platform.txt`
- `architecture/adr/ADR-005-terragrunt-architecture.txt`
