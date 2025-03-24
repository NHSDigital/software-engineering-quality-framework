# GitHub Actions Security Best Practices

## Introduction

GitHub Actions is a powerful automation tool that enables CI/CD workflows directly within your GitHub repository. Securing your GitHub Actions workflows is crucial to protect your code, secrets, and infrastructure from potential security threats.

This guide outlines best practices for securing your GitHub Actions workflows and minimizing security risks.

## Table of Contents

- [Secrets Management](#secrets-management)
- [Limiting Permissions](#limiting-permissions)
- [Third-Party Actions](#third-party-actions)
- [Dependency Management](#dependency-management)
- [Runner Security](#runner-security)
- [Pull Request Workflows](#pull-request-workflows)
- [OIDC Integration](#oidc-integration)
- [Audit and Monitoring](#audit-and-monitoring)

## Secrets Management

### Use GitHub Secrets

- Store sensitive data (API tokens, credentials, etc.) as [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- Never hardcode sensitive values in your workflow files
- Do not use structured data as a secret - this can cause GitHubs secret redaction in logs to fail
- Rotate secrets regularly
- Use environment-specific secrets when possible
- Ensure a secret scanner is deployed as part of your workflows
- Public repositories should enable GitHub Secret Scanner and Push Protection

### Minimize Secret Scope

```yaml
# Good practice - limiting secret to specific environment
jobs:
  deploy:
    environment: production
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy
        env:
          API_TOKEN: ${{ secrets.API_TOKEN }}
        run: ./deploy.sh
```

### Avoid Exposing Secrets in Logs

- Don't echo or print secrets in workflow steps
- Set debug to false when using secrets
- Use masking for any dynamically generated secrets

## Limiting Permissions

### Use Least Privilege Principle

Limit the GitHub token permissions to only what's necessary:

```yaml
permissions:
  contents: read
  pull-requests: write
  issues: write
```

### Use Fine-Grained Tokens

- Create custom GitHub Apps with limited scopes when possible
- Use repository-scoped tokens instead of organization-wide tokens

## Third-Party Actions

While third-party actions can significantly enhance the functionality and efficiency of your workflows, they also introduce potential security risks:

- *Untrusted Code*: Third-party actions are often maintained by external developers. If the code is not reviewed or vetted, it may contain vulnerabilities or malicious code that could compromise your repository or infrastructure.
- *Version Drift*: Using tags like @latest or branch references (e.g., @main) can lead to unexpected changes in behavior if the action is updated. This could introduce breaking changes or vulnerabilities into your workflows.
- *Dependency Vulnerabilities*: Third-party actions may rely on outdated or insecure dependencies, which could expose your workflows to known vulnerabilities.
- *Lack of Maintenance*: Some third-party actions may not be actively maintained, leaving them vulnerable to security issues or compatibility problems with newer GitHub Actions features.
- *Excessive Permissions*: Third-party actions may request more permissions than necessary, potentially exposing sensitive data or allowing unauthorized access to your repository.

To mitigate these risks, always follow best practices, such as pinning actions to specific commit SHAs, reviewing the source code of actions, and using only trusted actions from reputable sources.

### Pin Actions to Specific Versions

When including a GitHub Action within your workflow you should perform due diligence checks to ensure that the action achieves the aims you are intending it to, and that it doesn't do anything unintended, this would include performing a code review of the GitHub action code. To prevent the underlying code being changed without your awareness always use specific commit SHAs instead of tags or branches:

```yaml
# Not secure - can change unexpectedly
- uses: actions/checkout@v3 
# Better - using a specific version tag
- uses: actions/checkout@v3.1.0 
# Best - using a specific commit SHA
- uses: actions/checkout@2541b1294d2704b0964813337f33b291d3f8596b # v3.1.0
```

### Verify Third-Party Actions

- Only use trusted actions from the GitHub Marketplace
- Review the source code of third-party actions before using them
- Consider forking and maintaining your own copy of critical actions

### Use Actions Security Best Practices

- Enable Dependabot alerts for GitHub Actions
- Set up a workflow that regularly checks for outdated actions

## Dependency Management

### Scan Dependencies

- Use dependency scanning tools like GitHub's Dependabot

### Keep Dependencies Updated

- Implement automated dependency updates
- Regularly review and update dependencies with security patches

## Runner Security

### Self-hosted Runner Security

If using self-hosted runners:

- Run them in isolated environments (containers/VMs)
- Regularly update and patch runner machines
- Implement proper network isolation
- Use ephemeral runners when possible

```yaml
jobs:
  build:
    runs-on: [self-hosted, isolated]
    steps:
      # Your workflow steps here
```

### GitHub-hosted Runner Security

- Be aware that GitHub-hosted runners are reset after each job
- Clean up any sensitive data before job completion
- Don't store persistent sensitive data in the runner's environment

## Pull Request Workflows

### Secure Pull Request Workflows

- Don't expose secrets to pull request workflows from forks
- Use `pull_request_target` carefully with read-only permissions

```yaml
# Safer approach for PR workflows
on:
  pull_request: 
jobs:
  test:
    runs-on: ubuntu-latest
    permissions:
      contents: read
    steps:      
      - uses: actions/checkout@v3      
      - name: Run tests
        run: npm test
```

### Implement Required Reviews

- Enforce branch protection rules
- Require code reviews before merging
- Use status checks to enforce security scans

## OIDC Integration

### Use OpenID Connect for Cloud Providers

Instead of storing long-lived cloud credentials, use GitHub's OIDC provider:

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read
    steps:      
      - uses: actions/checkout@v3      
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/github-actions
          aws-region: eu-west-2
```

### Limit OIDC Token Claims

- Set specific subject claims in your cloud provider
- Implement additional claim conditions (repository, branch, environment)

## Audit and Monitoring

### Enable Audit Logging

- Monitor GitHub Actions usage via audit logs
- Set up alerts for suspicious activity

### Review Workflow Changes

- Enforce code reviews for workflow file changes
- Use CODEOWNERS to restrict who can modify workflow files

```plaintext
# CODEOWNERS file/.github/workflows/ @security-team
```

### Regular Security Reviews

- Conduct regular reviews of all workflows
- Update security practices based on emerging threats
- Monitor GitHub security advisories

## Additional Resources

- [GitHub Actions Security Hardening Guide](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [GitHub Security Lab](https://securitylab.github.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Security for GitHub Actions](https://docs.github.com/en/actions/security-for-github-actions)

## Conclusion

Securing GitHub Actions requires a multi-layered approach focusing on secrets management, permissions, third-party action vetting, and proper configuration. By following these best practices, you can significantly reduce security risks while still enjoying the full benefits of GitHub Actions automation.

Remember that security is an ongoing process - regularly review and update your security practices to adapt to new threats and challenges.
