# Secrets Strategy

## Purpose

This project uses a layered secrets strategy to keep credentials out of source control,
reduce blast radius, and make local development practical without weakening production
security.

Secrets are any values that would expose systems, users, infrastructure, or third-party
services if disclosed.

## Secret Inventory

The project may need the following secret types:

- Third-party API keys and access tokens
- Webhook signing secrets
- Database credentials
- Service-to-service credentials
- Encryption keys and key material references
- OAuth client secrets
- Local development tokens used for integration testing
- Temporary credentials for automation or deployment workflows

For this repository, some workflows may not require stored secrets at all.
Prefer IAM roles, short-lived credentials, and managed AWS integrations whenever
possible.

## Configuration Hierarchy

Configuration is resolved from least sensitive to most sensitive sources:

1. Application defaults in code
2. Non-secret configuration in documented environment variables
3. Environment-specific deployment configuration
4. Secrets stored in AWS Secrets Manager
5. Ephemeral credentials issued at runtime through AWS IAM or a trusted identity

Rules for the hierarchy:

- Secrets must never be committed to the repository.
- Non-secret configuration may be documented in `.env.example` or deployment files.
- If a value is sensitive, it belongs in a secret store, not in plain text docs.
- Production and non-production environments must use separate secret values.

## Naming Conventions

Use a predictable naming pattern so secrets are easy to discover and audit.

Recommended format:

```text
airbnb-marketing/<environment>/<service>/<secret-name>
```

Examples:

- `airbnb-marketing/dev/bedrock-agent/facebook-api-token`
- `airbnb-marketing/dev/automation/webhook-signing-secret`
- `airbnb-marketing/prod/app/database-password`

Guidelines:

- Use lowercase names with hyphens or slashes.
- Include the environment in the secret name.
- Include the owning service or component.
- Keep names stable across deployments when possible.
- Do not encode secret values, scopes, or expiration details in the name.

## Rotation Philosophy

Rotate secrets based on risk, not just on a calendar.

### Default Approach

- Use AWS-managed rotation when the secret type and integration support it.
- Prefer short-lived IAM credentials instead of long-lived static secrets.
- Rotate immediately if a secret is exposed, suspected to be exposed, or no longer
	trusted.

### Rotation Triggers

Rotate when:

- A secret is used in production and rotation is supported
- A team member with access leaves the project
- A provider recommends rotation after an incident or configuration change
- The secret has a known expiration or vendor policy
- A deployment or access pattern changes materially

### Rotation Rules

- Production secrets should have an explicit rotation owner.
- Non-production secrets may rotate less frequently, but they still must be replaceable.
- Rotation should be tested in lower environments before production rollout.
- Rotation procedures should avoid manual copy-paste where automation is feasible.

## Local Development Approach

Local development must be secure enough to be practical without encouraging secret
sprawl.

Recommended approach:

- Keep a checked-in `.env.example` with placeholder values only.
- Store local overrides in an ignored file such as `.env.local`.
- Use dummy or sandbox credentials for development whenever possible.
- Prefer mocked clients or stubbed integrations for workflows that do not require live
	third-party access.
- Use a separate AWS account or dedicated development environment for real cloud
	integration testing.
- Fetch production-like secrets only through explicit, authenticated access paths.

Local development should never depend on copying production secrets into a laptop or
sharing secrets through chat, screenshots, or ad hoc files.

## Access Principles

- Grant access to the smallest set of people and systems that need it.
- Prefer role-based access over shared static credentials.
- Log secret access where the platform supports it.
- Review and remove unused secret access regularly.

## Handling and Storage Rules

- Do not print secret values in logs.
- Do not embed secrets in prompts, examples, or documentation.
- Do not store secrets in plaintext source files.
- Redact sensitive values from debug output and issue reports.
- Use AWS Secrets Manager for long-lived secrets that need centralized lifecycle
	management.

## Summary

The goal of this strategy is to keep secrets centralized, named consistently, rotated
when risk changes, and isolated from source control while still supporting productive
local development.
