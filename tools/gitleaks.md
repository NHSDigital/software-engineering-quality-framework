# GitLeaks guidance

GitLeaks is the organisation's preferred tool for scanning repositories for accidentally committed secrets.

## Why secrets scanning matters

Secret scanning should cover two separate risks:

1. Secrets that already exist in repository history.
2. New secrets being introduced through day-to-day development.

Teams should treat any discovered secret as compromised, revoke or rotate it, and then remove it from Git history where necessary. See [Guidance for removing sensitive data from GitHub](../practices/guides/commit-purge.md).

## Minimum expectations

Use GitLeaks to enforce all of the following:

1. A full repository history scan before onboarding the tool.
2. Local scanning before code is pushed or merged.
3. CI scanning on every pull request and on the default branch.
4. Regular review of custom rules, allowlists and exclusions.

## Getting started

Install GitLeaks using the package manager or distribution method recommended for your platform in the official project documentation.

Typical verification commands are:

```bash
gitleaks version
gitleaks git --redact --verbose --log-opts="--all"
gitleaks dir . --redact --verbose
```

Use `gitleaks git` when you need to inspect commit history. Use `gitleaks dir` when you want to scan the current working tree.

## Local developer workflow

Teams should wire GitLeaks into local development so secrets are caught before they are pushed.

One option is to use `pre-commit`:

```yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.24.2
    hooks:
      - id: gitleaks
```

If your team uses another hook manager, apply the same principle: run GitLeaks automatically before changes leave a developer workstation.

## CI integration

Run GitLeaks in CI so every repository has a server-side control as well as local checks.

Example GitHub Actions step:

```yaml
- name: Run GitLeaks
  run:  docker run --rm --platform linux/amd64 \
            -v "$(pwd):/repo" \
            -w /repo \
            ghcr.io/gitleaks/gitleaks:v8.30.1 \
            git --source /repo --redact --verbose --log-opts="--all"
```

If you maintain a custom configuration, store it in the repository and reference it explicitly in local and CI commands so the same rules apply everywhere.

## Rule management

Start with the default GitLeaks ruleset and add repository-specific rules only where needed.

When adding allowlists or exclusions:

1. Keep them as narrow as possible.
2. Record why they are needed.
3. Review them regularly and remove them when no longer justified.

## Further reading

- [GitLeaks](https://github.com/gitleaks/gitleaks)
- [GitLeaks configuration](https://github.com/gitleaks/gitleaks#configuration)
- [GitLeaks pre-commit integration](https://github.com/gitleaks/gitleaks#pre-commit)
