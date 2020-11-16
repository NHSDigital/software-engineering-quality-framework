# Security

## Context

* These notes are part of a broader set of [principles](../principles.md)
* This is related to [ARCHITECTURE-SECURITY](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/adopt-appropriate-cyber-security-standards)

## Big picture

- Understand what **data** is processed or stored in the system
  - Assess the data classification e.g. [PII](https://ico.org.uk/for-organisations/guide-to-data-protection/guide-to-the-general-data-protection-regulation-gdpr/key-definitions/what-is-personal-data/), [PCI](https://www.pcisecuritystandards.org/pci_security/glossary#C), company confidential
  - Understand compliance requirements, e.g. GDPR and ISO
- Consider whether the data being processed is all **necessary** for the system to function, or whether it could be reduced to minimise risk
  - Prefer use of managed services to reduce attack surface where possible
- Keep **audit** log(s) of user actions, software and infrastructure changes (e.g. git, CI/CD, [CloudTrail](https://aws.amazon.com/cloudtrail/))

## Application level security

- Cover the **basics**
  - Ensure the [OWASP Top Ten](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_2017_Project) is well understood and considered during software delivery
  - Encode/validate all user input. Code against (and test for) XSS and injection attacks such as SQL/XML/JSON/CRLF
- Ensure **authentication** is robust
  - Strong passwords and MFA
  - Secure storage of session token (`Secure`, `HttpOnly` and `SameSite`) which is refreshed on privilege escalation to avoid session hijacking/fixation
  - Strong hash and salt if storing passwords
  - Clear and consistent permissions model
  - Minimum necessary feedback on failed authentication e.g. 404 or blanket 403 when not authenticated to avoid leaking whether resources exist
  - Guard against time based authentication attacks, e.g. using a WAF
- Guarded against invalid **certificates** e.g. expiry monitoring.
  - Consider [OCSP stapling](https://blog.cloudflare.com/high-reliability-ocsp-**stapling**/) for improved performance
- Ensure **cookies** cannot leak from production to non-produnction environments e.g. avoid non-produnction on subdomain of production domain
- Prevent **[clickjacking](https://sudo.pagerduty.com/for_engineers/#clickjacking)** with `X-Frame-Options`
- Be careful not to **leak information**, e.g. error messages, stack traces, headers
- **Don't trust** yourself or others!
  - Scan source code automatically for secrets or other sensitive data (see [everything as code](../patterns/everything-as-code.md) for details).
  - Be wary of any 3rd party JavaScript included on the page, e.g. for A/B testing, analytics
  - Pin dependencies at known versions to avoid unexpected updates
  - Scan dependencies for vulnerabilities, e.g. using [OWASP Dependency Check](https://www.owasp.org/index.php/OWASP_Dependency_Check) or [Snyk](https://snyk.io/)
  - Scan running software, e.g. using [OWASP ZAP](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project)
- **Automate** security testing &mdash; on every build if practical
  - Generate test data in a way that avoids including personally identifiable information

## Infrastructure security

- **Encrypt** data at rest and in transit
  - Consider restricting to TLS 1.2 or later only
  - Consider enabling only [Perfect Forward Secrecy](https://en.wikipedia.org/wiki/Forward_secrecy) cipher suites (e.g. [ECDHE](https://en.wikipedia.org/wiki/Elliptic-curve_Diffie%E2%80%93Hellman))
- **Scan and refresh** systems and software when required to keep them secure, e.g. using [Prisma](https://www.paloaltonetworks.com/prisma/cloud/cloud-workload-protection-platform) (formerly Twistlock), [Clair](https://github.com/quay/clair) or [ECR image scanning](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html) for container base images, or [Amazon Inspector](https://aws.amazon.com/inspector/) for VMs
  - Scan before deployment and periodically in live for components no longer receiving regular deployments
- **Minimise access** to production
  - Logging & monitoring should negate the need to manually inspect a production host
  - All deployments should be done via delivery pipelines, negating the need to manually change a production host
  - If possible, only allow access for emergencies using a "break glass" pattern, e.g. using Azure AD [Privileged Identity Management](https://docs.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-configure)
  - Audit access to production and alert for unexpected access
- Ensure infrastructure **IAM** is robust
  - Strong passwords and MFA
  - Segregate workloads, e.g. in separate AWS accounts ([Landing Zone](https://aws.amazon.com/solutions/aws-landing-zone/), [Control Tower](https://aws.amazon.com/controltower/features/`)) or Azure [subscriptions](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/decision-guides/subscriptions/)
  - Fine grained, least privilege IAM roles
- Secure **CI/CD**
  - Robust authentication and minimum privileges
  - Prefer ambient IAM credentials over retrieving credentials from secrets management. Do not store credentials in the plain.
- **Enforce** infrastructure security (e.g. [Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview), [AWS Config](https://aws.amazon.com/config/)) and validate it (e.g. [ScoutSuite](https://github.com/nccgroup/ScoutSuite/blob/master/README.md))?
- Lock down your **networks**
  - Restrict external and internal network traffic by appropriate firewall rules
  - Consider using a WAF (Web Application Firewall)
  - Restrict outbound network calls to limit the damage a compromised component can do if practical

## Human factors
- Ensure **joiners and leavers process** is adequate
- Encourage use of **password managers** with MFA enabled
- Be aware of security sign-off **policies or procedures** outside the team and engage with these early
