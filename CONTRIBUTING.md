# Contributing Guide

Thank you for your interest in contributing to this project.
This guide explains how to propose changes, submit pull requests, and collaborate
effectively.

## Quick Start

1. Fork the repository.
2. Create a feature branch from `main`.
3. Make focused, well-documented changes.
4. Run tests and checks locally.
5. Open a pull request with a clear description.

Current project status:

- `Makefile` exists but currently has no targets.
- `src/` and `tests/` are scaffolded and currently contain `.gitkeep` placeholders.
- Most active contribution work at this stage is in docs, architecture artifacts, and
	module materials.

## Development Workflow

1. Sync your fork with `main` before starting new work.
2. Create a branch using a descriptive name:
	- `feature/<short-description>`
	- `fix/<short-description>`
	- `docs/<short-description>`
3. Keep commits small and meaningful.
4. Rebase on top of the latest `main` when needed.

Example:

```bash
git checkout main
git pull upstream main
git checkout -b feature/improve-agent-prompt
```

## Repository Structure

Contributors commonly work in these directories:

- `src/` - primary source code
- `tests/` - automated tests
- `docs/` - documentation
- `examples/` - sample usage
- `scripts/` - utility scripts
- `infrastructure/` - deployment/bootstrap/CDK/policies
- `book/` - course-style learning modules and labs
- `architecture/` - ADRs and design diagrams

Please place changes in the most relevant directory and avoid unrelated refactors in
the same pull request.

## Coding Standards

- Follow existing naming, formatting, and file organization conventions.
- Prefer readability over cleverness.
- Add comments only when logic is non-obvious.
- Keep public interfaces stable unless intentionally changing them.
- Update documentation when behavior changes.

## Testing

At the moment, there is no repository-wide automated test command yet.

Until automated checks are added, contributors should run this lightweight validation
before opening a PR:

```bash
git status
git diff --stat
```

And verify:

- Changed files are intentional and scoped to your PR.
- Markdown renders correctly for updated `.md` docs.
- Any referenced paths exist in the repository.
- Diagrams/docs remain consistent with architecture intent.

If your PR introduces runnable code, include:

- The exact command(s) you used to validate it.
- Any setup steps required for reviewers.

When the project adds standard test/lint commands, this section should be updated to
require those commands explicitly.

## Documentation Expectations

Update relevant docs when introducing:

- New features
- Breaking changes
- New environment variables/configuration
- New scripts or workflows

Potential files to update include:

- `README.md`
- `docs/`
- `examples/`
- `architecture/adr/` (for significant design decisions)

## Commit Message Guidelines

Use clear, imperative commit messages.

Recommended style:

```text
<type>: <summary>
```

Examples:

- `feat: add retry handler for agent orchestration`
- `fix: handle null response from bedrock runtime`
- `docs: expand setup instructions for local development`

## Pull Request Guidelines

Each pull request should:

- Have a concise title and clear description.
- Reference related issues (for example: `Closes #123`).
- Explain what changed and why.
- Describe testing performed.
- Include screenshots/logs when helpful.

For this repository's current stage, include a short validation note such as:

```text
Validation performed:
- Checked markdown rendering for updated docs
- Verified links/paths referenced in docs exist
```

Please keep pull requests focused. Smaller PRs are easier to review and merge.

## Issue Reporting

When opening an issue, include:

- Expected behavior
- Actual behavior
- Steps to reproduce
- Environment details (OS, language/runtime versions)
- Relevant logs or screenshots

For security-related concerns, follow the guidance in `SECURITY.md`.

## Code of Conduct

By participating in this project, you agree to follow our Code of Conduct:

- `CODE_OF_CONDUCT.md`

## Review Process

- Maintainers will review contributions as time permits.
- Feedback may request changes before merge.
- Once approved, a maintainer will squash/merge according to project standards.

Thank you for contributing and helping improve this project.
