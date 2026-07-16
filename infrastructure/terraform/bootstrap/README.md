# Bootstrap Implementation Checklist

This README is the execution checklist for the bootstrap platform layer.

Reference documents:

- `docs/platform/bootstrap-platform.md`
- `architecture/adr/ADR-006-bootstrap-platform.txt`

## Goal

Provision the minimum shared platform prerequisites required before Terragrunt
environment stacks are applied.

## Scope

Bootstrap should provision only foundational resources such as:

- Terraform backend prerequisites
- IAM roles and policies for infrastructure execution
- Shared tags or metadata primitives used across environments

Bootstrap should not provision workload-specific application resources.

## Prerequisites

Before implementation:

- [ ] AWS account and region strategy is documented
- [ ] Naming conventions are documented and approved
- [ ] Secrets strategy is defined in `docs/security/secrets-strategy.md`
- [ ] Terraform and Terragrunt platform strategy is reviewed

Before first apply:

- [ ] Bootstrap module inputs are defined in `variables.tf`
- [ ] Bootstrap outputs for downstream consumers are defined in `outputs.tf`
- [ ] Providers and required versions are pinned in `providers.tf` and `versions.tf`
- [ ] Remote state approach is documented and approved

## Implementation Phases

### Phase 1: Structure and Contracts

- [ ] Define module boundaries in `main.tf`
- [ ] Define input contracts in `variables.tf`
- [ ] Define output contracts in `outputs.tf`
- [ ] Add module-level comments for non-obvious decisions

Exit criteria:

- [ ] Files compile syntactically
- [ ] Inputs and outputs match planned Terragrunt consumption

### Phase 2: Backend Foundations

- [ ] Implement backend primitives in `backend/`
- [ ] Ensure state encryption and locking strategy is enforced
- [ ] Define deterministic state naming/path conventions

Exit criteria:

- [ ] Backend design supports isolated environment state
- [ ] Backend conventions are documented for operators

### Phase 3: IAM Foundations

- [ ] Implement execution roles and policies in `iam/`
- [ ] Enforce least-privilege policy boundaries
- [ ] Document trust relationships and access assumptions

Exit criteria:

- [ ] Roles are scoped to bootstrap and infrastructure workflows
- [ ] High-risk permissions are justified and documented

### Phase 4: Validation and Handoff

- [ ] Run `terraform fmt -recursive`
- [ ] Run `terraform validate`
- [ ] Run `terraform plan` and review diff
- [ ] Apply in non-production first
- [ ] Verify outputs used by Terragrunt environments

Exit criteria:

- [ ] Bootstrap state is healthy and recoverable
- [ ] Output values are stable and documented
- [ ] Terragrunt environment initialization can proceed

## Operational Guardrails

- Changes in this folder require reviewer sign-off.
- Destructive bootstrap changes require explicit approval.
- Production bootstrap changes require manual approval.
- Emergency changes must include follow-up remediation notes.

## Recovery Checklist

If bootstrap resources fail or drift:

- [ ] Identify whether failure is backend, IAM, or configuration contract related
- [ ] Restore backend availability first
- [ ] Restore execution identity and permissions second
- [ ] Re-run validation and plan before any corrective apply
- [ ] Document incident details and lessons learned

## Handoff Artifacts

When bootstrap is ready for broader use, publish:

- [ ] Finalized input variable table
- [ ] Output contract table for Terragrunt consumers
- [ ] Bootstrap apply procedure and rollback notes
- [ ] Environment onboarding steps for dev, test, and prod

## Change Governance

Any structural change to bootstrap architecture must update:

- `docs/platform/bootstrap-platform.md`
- `architecture/adr/ADR-006-bootstrap-platform.txt`
