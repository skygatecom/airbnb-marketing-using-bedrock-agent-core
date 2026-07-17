# Security Policy

## Supported Scope

This repository is under active development. Security reports are welcome for all
current repository contents, including:

- Source code in `src/`
- Infrastructure definitions in `infrastructure/`
- Scripts in `scripts/`
- Examples and reference implementations in `examples/`
- Documentation that could lead to insecure deployment or usage

Because the project is evolving, some areas may be incomplete or instructional in
nature. Even so, security issues in design, code, configuration, or documentation
should still be reported.

## Reporting a Vulnerability

Please do not report security vulnerabilities through public GitHub issues, pull
requests, or discussions.

Instead, report them privately to the project maintainers through your preferred
private contact channel for this repository.

If a dedicated security email address is later added, this policy should be updated
to include it.

When submitting a report, include:

- A clear description of the issue
- Affected files, components, or workflows
- Steps to reproduce the problem
- Proof of concept, logs, or screenshots if available
- Potential impact
- Any suggested remediation, if known

## What to Expect

Maintainers will aim to:

- Acknowledge receipt of the report within 5 business days
- Review and triage the issue as quickly as possible
- Request clarification if more detail is needed
- Work on a fix and coordinate disclosure where appropriate

Response times may vary depending on maintainer availability and the complexity of
the issue.

## Responsible Disclosure

We ask reporters to:

- Give maintainers reasonable time to investigate and remediate the issue
- Avoid publicly disclosing the vulnerability until a fix or mitigation is available
- Avoid accessing, modifying, or deleting data that does not belong to you
- Avoid actions that would degrade service, disrupt workflows, or harm users

We will make a good-faith effort to investigate all legitimate reports and address
confirmed vulnerabilities appropriately.

## Security Priorities for This Project

Because this project is focused on AI agents, AWS architecture, and automation,
special attention should be given to:

- Secrets handling and credential exposure
- IAM permissions and least-privilege design
- Bedrock and agent prompt safety
- Input validation and tool execution safety
- Logging of sensitive data
- Infrastructure misconfiguration
- Unsafe example defaults in documentation

## Secure Contribution Guidelines

Contributors should follow these practices when adding code, infrastructure, or docs:

- Never commit secrets, tokens, credentials, or private keys
- Prefer least-privilege IAM policies
- Document security-sensitive configuration clearly
- Avoid unsafe defaults in examples and templates
- Sanitize or redact sensitive logs before sharing them
- Consider misuse, prompt injection, and over-permissioning risks in agent workflows

## Disclosure and Fixes

When a vulnerability is confirmed, maintainers may:

- Prepare a private fix
- Publish a patch
- Document mitigations or workarounds
- Announce the issue after remediation, when appropriate

The exact disclosure process will depend on severity, exploitability, and whether
downstream users may be affected.

## No Security Guarantees

This project is provided as-is. While we aim to follow sound security practices,
we do not guarantee that the repository is free of vulnerabilities.
