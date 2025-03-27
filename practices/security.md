# Security

- [Security](#security)
  - [Context](#context)
  - [Use the NCSC guidance](#use-the-ncsc-guidance)
  - [Test first](#test-first)
  - [Recommendations](#recommendations)
    - [Big picture](#big-picture)
    - [Application level security](#application-level-security)
    - [Infrastructure security](#infrastructure-security)
    - [Human factors](#human-factors)

## Context

- These notes are part of a broader set of [principles](../principles.md)
- This is related to [ARCHITECTURE-SECURITY](https://digital.nhs.uk/developer/architecture/principles/adopt-appropriate-cyber-security-standards)
- :warning:Any deviation away from these security practices **must** be discussed with your security lead

## Use the NCSC guidance

The National Cyber Security Centre provides excellent [secure development and deployment guidance](https://www.ncsc.gov.uk/collection/developers-collection) on how to embed security into software delivery.

This guidance outlines 8 principles and gives detailed practical steps for each on the pages linked.

1. [Secure development is everyone's concern](https://www.ncsc.gov.uk/collection/developers-collection/principles/secure-development-is-everyones-concern)
_Genuine security benefits can only be realised when delivery teams weave security into their everyday working practices._
1. [Keep your security knowledge sharp](https://www.ncsc.gov.uk/collection/developers-collection/principles/keep-your-security-knowledge-sharp)
_Give your developers and delivery team the time and resources necessary to form a good understanding of defensive code development and the risks to the systems they are building._
1. [Produce clean & maintainable code](https://www.ncsc.gov.uk/collection/developers-collection/principles/produce-clean-maintainable-code)
_Complexity is the enemy of security... Clean, well documented code is more efficient and easier to develop. It will also be easier to secure._
1. [Secure your development environment](https://www.ncsc.gov.uk/collection/developers-collection/principles/secure-your-development-environment)
_If your development environment is insecure, it's difficult to have confidence in the security of the code which comes from it. These environments need to be suitably secure, but should also facilitate and not impede the development process._
1. [Protect your code repository](https://www.ncsc.gov.uk/collection/developers-collection/principles/protect-your-code-repository)
_Your code is only as secure as the systems used to create it. As the central point at which your code is stored and managed, it's crucial that the repository is sufficiently secure._
1. [Secure the build and deployment pipeline](https://www.ncsc.gov.uk/collection/developers-collection/principles/secure-the-build-and-deployment-pipeline)
_There are huge efficiency savings to be had from automating functions such as building code, running tests and deploying reference environments. However, these processes are security critical. Take care to ensure that your build and deployment tooling cannot undermine the integrity of your code, and that key security processes cannot be bypassed before changes are pushed to your customers._
1. [Continually test your security](https://www.ncsc.gov.uk/collection/developers-collection/principles/continually-test-your-security)
_Performing security testing is critical in detecting and fixing security vulnerabilities. However, it should not get in the way of continuous delivery. Automating security testing where possible provides you with easily repeatable, scalable security measures. Your specialist security people can then concentrate on finding subtle and uncommon weaknesses._
1. [Plan for security flaws](https://www.ncsc.gov.uk/collection/developers-collection/principles/plan-for-security-flaws)
_All code is susceptible to bugs and security vulnerabilities... Accept that your code will have exploitable shortcomings and establish a process for capturing and managing them from identification through to the release of a fix._

## Test first

As with writing good code, doing good security involves continual testing &mdash; in many cases using the tests to steer implementation.

The [OWASP Web Security Testing Guide](https://github.com/OWASP/wstg/tree/master/document) is an extensive and wide-reaching reference on how to test for security, including examining the software delivery process and reviewing code as well as more traditional black box penetration testing. It is a large resource, but is worth investing some time in for the security-concious.

## Recommendations

The remainder of this page gives more detailed and specific recommendations to be read in conjunction with the above.

### Big picture

- Understand what **data** is processed or stored in the system
  - Assess the data classification e.g. personal confidential data (PCD), aggregate data, anonymised data, publicly available information. See [Health and social care data risk model](https://digital.nhs.uk/data-and-information/looking-after-information/data-security-and-information-governance/nhs-and-social-care-data-off-shoring-and-the-use-of-public-cloud-services)
  - Understand governance and compliance requirements which apply, e.g. [NHS guidance](https://digital.nhs.uk/data-and-information/looking-after-information/data-security-and-information-governance/nhs-and-social-care-data-off-shoring-and-the-use-of-public-cloud-services), GDPR
- Consider whether the data being processed is all **necessary** for the system to function, or whether it could be reduced to minimise risk
  - Prefer use of managed services to reduce attack surface where possible
- Keep **audit** log(s) of user actions, software and infrastructure changes (e.g. git, CI/CD, [CloudTrail](https://aws.amazon.com/cloudtrail/))
- Ensure testing is conducted continually, appropriately and relevent to the design and development environment (for further details please see [testing](testing.md), [continuous integration](continuous-integration.md), [automate everything](../patterns/automate-everything.md) and [fast feedback](../patterns/fast-feedback.md)).

### Application level security

- Cover the **basics**
  - Ensure the [OWASP Top Ten](https://owasp.org/www-project-top-ten/) is well understood and considered during software delivery, other risks outside of the Top Ten should not be discounted however
    - Static code analysis tools can catch some of these issues early, for example [SonarQube](https://www.sonarqube.org/features/security/owasp/)
    - Beware of over-reliance on automated tools: they can help to catch some issues, but they cannot be relied on to catch everything
  - Encode/validate all user input. Code against (and test for) XSS and injection attacks such as SQL/XML/JSON/CRLF
- Ensure **authentication** is robust and appropriate for the level of data being handled.
  - Strong passwords and MFA
  - Secure storage of session token (`Secure`, `HttpOnly` and `SameSite`) which is refreshed on privilege escalation to avoid session hijacking/fixation
  - Any secrets should be stored in a vault
  - Clear and consistent permissions model
  - Minimum necessary feedback on failed authentication e.g. 404 or blanket 403 when not authenticated to avoid leaking whether resources exist
  - Guard against time based authentication attacks, e.g. using a WAF
- Guarded against invalid **certificates** e.g. expiry monitoring.
  - Consider <!-- markdown-link-check-disable -->[OCSP stapling](https://blog.cloudflare.com/high-reliability-ocsp-stapling/)<!-- markdown-link-check-enable --> for improved performance
- Ensure **cookies** cannot leak from production to non-production environments e.g. avoid non-production on subdomain of production domain
- Prevent **[clickjacking](https://sudo.pagerduty.com/for_engineers/#clickjacking)** with `X-Frame-Options`
- Be careful not to **leak information**, e.g. error messages, stack traces, headers
- **Don't trust** yourself or others! <a name='secret-scanning'></a>
  - Code must be automatically scanned for secrets or other sensitive data. We have a [secret scanning guide](../tools/nhsd-git-secrets/README.md) that describes how to best achieve this using our preferred tooling, and also includes examples to get you started.
  - Be wary of any 3rd party JavaScript included on the page, e.g. for A/B testing, analytics
  - Pin dependencies at known versions to avoid unexpected updates
  - Scan dependencies for vulnerabilities, e.g. using [OWASP Dependency Check](https://owasp.org/www-project-dependency-check/) or [Snyk](https://snyk.io/)
  - Scan running software, e.g. using [Zed Attack Proxy](https://www.zaproxy.org/)
- **Automate** security testing &mdash; on every build if practical
  - Generate test data in a way that avoids including personally identifiable information
- When granting roles to CI/CD tools, use different roles for the different stages in the deployment pipeline &mdash; for example so that a deployment meant for a development account cannot be performed against a production account

### Infrastructure security

- [Discuss](https://digital.nhs.uk/cyber-and-data-security/managing-security/nhs-secure-boundary#register-for-the-service) your use-case with the [NHS Secure Boundary service](https://digital.nhs.uk/cyber-and-data-security/managing-security/nhs-secure-boundary) to explore what the service already provides or can offer in terms of data egress/ingress
- **Encrypt** data at rest and in transit
  - TLS versions shall be ideally v1.3 or v1.2 as a minimum. Anything less, as at the end of 2020 will be obsolete and an up-to-date version of the protocol will be required. If a system or service is still utilising anything less than v1.2 then a risk must be raised and managed accordingly.
  - Consider enabling only [Perfect Forward Secrecy](https://en.wikipedia.org/wiki/Forward_secrecy) cipher suites (e.g. [ECDHE](https://en.wikipedia.org/wiki/Elliptic-curve_Diffie%E2%80%93Hellman))
- **Scan and refresh** systems and software when required to keep them secure, e.g. using [Prisma](https://www.paloaltonetworks.com/prisma/cloud/cloud-workload-protection-platform) (formerly Twistlock), [Clair](https://github.com/quay/clair) or [ECR image scanning](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html) for container base images, or [Amazon Inspector](https://aws.amazon.com/inspector/) for VMs
  - Scan before deployment and periodically in live for components no longer receiving regular deployments
- **Minimise access** to production
  - Logging & monitoring should negate the need to manually inspect a production host
  - All deployments should be done via delivery pipelines, negating the need to manually change a production host
  - Only allow access for emergencies using a "break glass" pattern, e.g. using Azure AD [Privileged Identity Management](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure)
  - Audit access to production and alert for unexpected access
  - Frequently asked questions:
    - Q: If I can't access production, how can I check data, for example to respond to a support call? A: one approach is to build a facility (which must be automated, controlled and secured - so likely to be triggered via a pipeline) to clone the production database into a short-lived and isolated copy, so that data can be checked safely without anyone accessing production. Read-replicas can potentially be used instead, but they are (obviously) limited to read-only, and will often consume more cost and energy than on-demand clones ([ARCHITECTURE-SUSTAINABILITY](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/deliver-sustainable-services)). As above, access must be audited and strictly controlled.
    - Q: If I can't access production, how can I update data that is incorrect? A: to update data safely and with confidence, all data changes should be scripted, tested against production data (using a clone, as above) and applied (both for testing and to production) via delivery pipelines rather than via manual updates.
    - Q: If I can't access production, how can I refresh static / reference data? A: as above, one approach is to script the data changes required and apply them via delivery pipelines; another approach is to build a housekeeping facility that refreshes an entire static dataset based on a file (for example CSV or JSON) - if using this approach, access and usage must be audited and strictly controlled.
- **Secure the route** to infrastructure: all access to infrastructure (production or otherwise) must be via a secured route, for example via a hardened bastion only accessible via a VPN (with MFA challenge), and with an audit of usage.
- Ensure infrastructure **IAM** is robust
  - Strong passwords and MFA
- **Secure deployment** infrastructure.
  - [Maual deployments should be avoided.](../patterns/deployment.md#manual-deployments)
  - Deployment routes should be secured and should be considered access to Production systems.
  - Consider the way code is [promoted through development environments to production.](../patterns/deployment.md#promotion-through-path-to-live-environments)

    <details><summary>Example IAM policy to prevent assume role without MFA (click to expand)</summary>

    ```yaml
    {
        "Version": "2012-10-17",
        "Statement": {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::<your_account_id>:role/Administrator",
            "Condition": {
                "BoolIfExists": {
                    "aws:MultiFactorAuthPresent": "true"
                }
            }
        }
    }
    ```

    </details>
  - Segregate workloads, e.g. in separate AWS accounts ([Landing Zone](https://aws.amazon.com/solutions/aws-landing-zone/), [Control Tower](https://aws.amazon.com/controltower/features/)) or Azure [subscriptions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions)
  - Fine grained, least privilege IAM roles
- Secure **CI/CD**
  - Robust authentication and minimum privileges
  - Prefer ambient IAM credentials over retrieving credentials from secrets management. Do not store credentials in the plain.
  - If using GitHub Actions follow the [Best Practices outlined here](./actions-best-practices.md)
- **Enforce** infrastructure security (e.g. [Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview), [AWS Config](https://aws.amazon.com/config/)) and validate it (e.g. [ScoutSuite](https://github.com/nccgroup/ScoutSuite/blob/master/README.md))

  <details><summary>Example IAM policy fragment to prevent unencrypted RDS databases (click to expand)</summary>

    ```yaml
    {
      "Sid": "",
      "Effect": "Deny",
      "Action": "rds:CreateDBInstance",
      "Resource": "*",
      "Condition": {
        "Bool": {
          "rds:StorageEncrypted": "false"
        }
      }
    }
    ```

  </details>

  <details><summary>If enforcement is not possible / appropriate, use alerts to identify potential issues: example AWS Config rule to identify public-facing RDS databases (click to expand)</summary>

    ```yaml
    {
      "ConfigRuleName": "RDS_INSTANCE_PUBLIC_ACCESS_CHECK",
      "Description": "Checks whether the Amazon Relational Database Service (RDS) instances are not publicly accessible. The rule is non-compliant if the publiclyAccessible field is true in the instance configuration item."
      "Scope": {
        "ComplianceResourceTypes": [
          "AWS::RDS::DBInstance"
        ]
      },
      "Source": {
        "Owner": "AWS",
        "SourceIdentifier": "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
      }
    }
    ```

  </details>

- Lock down your **networks**
  - Restrict external and internal network traffic by appropriate firewall rules
  - Consider using a WAF (Web Application Firewall)
  - Restrict outbound network calls to limit the damage a compromised component can do if practical

### Human factors

- Ensure **joiners and leavers process** is adequate
- Encourage use of **password managers** with MFA enabled
- Be aware of security sign-off **policies or procedures** outside the team and engage with these early
