# Deployment Strategies

When developing services and applications development teams must consider their approach to deploying new releases.

This is a fundamental step in the design of the solution, development teams must consider the technical impact of different strategies alongside the impact to service during deployments. This starts at the point of building the CI pipelines and permeates through to final live deployment pipelines. Different approaches may be applicable depending on the chosen approach, for example serverless deployments as opposed to VM based deployments.

Deployments must be repeatable and [idempotent](../practices/continuous-integration.md#deploy-what-you-tested), so that deploying the same version twice will result in the dame deployed environment.

## CI/CD pipeline-based deployment

As part of the development process, a [CI/CD pipeline](../practices/continuous-integration.md) will be created. This pipeline will be designed to run unit, integration and other tests and formatting/linting checks, code quality checks, security checks and accessibility checks, successfully before merging into the main branch.

### Immutable signed deployment artefacts

Following a merge from your feature branch development teams must ensure that all appropriate tests are performed, once all tests have passed a [deployment artefact](../practices/continuous-integration.md#deploy-what-you-tested) should be created if applicable. This means that there is a fully tested, known-good, signed deployment artefact that can be used to confidently deploy to other environments. These artefacts should be immutable, tagged, signed and stored in a location where they are accessible to all environments (e.g., GitHub or an s3 bucket).

### Promotion through path-to-live environments

These artefacts should be used to deploy to environments on your path-to-live, and then finally to production/live. The development team should think about what environments are required, some example environments are:

1. Dev environments
1. Integration test environments
1. User Acceptance Test environments
1. Non functional / pre-production / live-like environment
1. Production environment

Manual deployments should be restricted wherever possible, even in development environments automation of deployments and the ability to rapidly spin up and down environments is key, manual deployments can lead to infrastructure being left running and potential issues with deployments that are costly to identify and resolve. The pre-production environment must be used to test deployments to ensure that the new release will go smoothly into the production environment.

Other things worth considering are whether the team requires a different testing environment for any manual/accessibility testing (but think how this can be automated in the CI/CD pipeline). Does the project require supplier testing against the latest version before it is promoted to production, and is a separate environment required for this? Development teams should also consider the implications on their spend of multiple environments, particularly where there is a high reliance on Cloud-based testing environments. Teams should implement controls to shut down environments and should give particular thought to the frequency and duration of ephemeral environments.

Finally, development teams should ensure that no lower environment (e.g., dev, test) has access to a higher environment (e.g., preprod/production). It is an anti-pattern to push artefacts up to a higher environment from a lower one, or to run a deployment runner instance in dev that deploys to production. Development teams should consider using a pull model from their higher-level environments. In this scenario the build artefacts would get pushed to a repository,  for example published to GitHub and each environment would pull this release down as part of their deployment process.

Using a "management" account to perform deployment / orchestration activities can lead to issues with users having too much permission in the management account to support the work they need to perform in a development environment and these permissions leaking into the access for the production environment. Therefore, it is essential to restrict permissions and to utilise separate roles to enable deployments to different environments. Access to the Management account must be restricted and monitored at the same level as access to the production accounts that this account supports.

## Continuous deployment vs approval gateways

The target approach of CI/CD is continuous deployment, every Pull Request completed in dev gets promoted through environments and tests automatically until it is automatically deployed to production.

However this presents challenges due to clinical, security, service and other approval requirements, and the release windows assigned to specific products. In these situations development teams should consider Continuous Delivery, and automatically build artefacts that are ready to deploy to production. As confidence grows teams should look to migrate to more frequent smaller deployments in discussion with their Live service teams.

Further, teams must implement approval gateways in their CD pipeline, and assess building of integration with service management tools to automate releases to production during the release window once approved. These approval gateways may just include code review depending on the context and risks for the specific service. Teams should review the [Governance as a side effect](https://github.com/NHSDigital/software-engineering-quality-framework/blob/main/patterns/governance-side-effect.md) pattern and should aspire to bake in as many of these checks and reviews into the delivery process as this will negate or minimise the need for downstream reviews.

## Manual deployments

Manual deployments and [all access to production](../practices/security.md#infrastructure-security) should be avoided. If they are required then development teams should minimise the required access rights the deploying person requires. This person should not need full admin rights to execute the process.

For example, one possible way of starting manual deployments in AWS (e.g., rolling back to a specific version) would be to have a user who only has write access to one SSM parameter store value, which is the version to install. AWS Event Bridge can monitor a change to this variable, and automatically trigger an AWS Code Build pipeline that uses a more privileged service role to perform the installation.

## Zero-downtime deployments

Development teams must build systems and deployment patterns in such a way as to achieve zero downtime deployments, where this is not required, due to service levels and complexity teams should highlight and ensure the decision has been ratified through an [Any Decision Record](../any-decision-record-template.md) document.

To achieve zero downtime deployments the implemented deployment strategy must be “Blue-Green”.

Blue-green deployments are a technique for safely rolling out updates to a software application. It involves maintaining two identical production environments (or distinct components, e.g. by cycling through nodes and deploying one at a time while the service continues to handle live load and bringing the new updated services into load in a controlled manner) and ensuring that traffic is routed to only one of these environments. At deployment time, one of the environments is “Live” and receiving all production traffic, while the other environment is idle. At deployment time the release is tested and deployed to the idle environment (known as the green environment) (some teams may elect to deploy to the live environment keeping the idle environment available as a fall back). Once initial smoke tests have been completed the production traffic can be routed to the green environment with the blue environment becoming idle. The new release should be allowed to soak for a defined period, if any issues arise with the release, it can be quickly rolled back by routing traffic away from the green environment back to the idle blue environment. Development teams should look to run automated tests, through their pipeline, following the deploy to build confidence that the deployment was successful.

After a suitable period, the blue environment can then be uplifted to the latest release, or alternatively stood down until the next release is ready.

Utilising this mechanism means that teams can rapidly fail away from an issue associated with the release onto a known good version of the service.

## Roll-back strategies

Engineering teams should consider the potential impact to their service of a failed deployment and the appropriate mechanisms to ensure they are able to revert a deployment quickly and easily. This failed deployment mechanism should ideally be tested regularly as part of the test lifecycle. Ideally this mechanism would be to revert the service to the leg that has not been deployed to. In some cases, teams may decide that it is not possible to achieve a roll back, in these cases the deployment must be flagged with Service management and the Engineering management as a “High Risk” deployment. Teams should expect to justify why it is not possible to provide a rollback option and should consider alternative risk mitigation activities.

Particular care should be taken around deployments for serverless architectures with a thought being given to idempotent data workflows and clear version control strategies. Other strategies to reduce the risk in such situations are more frequent and smaller changes.

## Example deployment pipeline stages

The following table includes steps that development teams should consider when planning their deployment strategy, it assumes a CI/CD pipeline deploying each merge to main into production, development teams would need to review these steps against their specific needs and governance cycles.

| Step | Description | Actor | Stage |
| :---: | --- | --- |
| 1 | Developer makes changes to their branch. | Developer | Development |
| 2 | Changes are committed to their remote branch. | Developer | Development |
| 3 | Majority of tests run (including linting, security). Ideally all tests if acceptable runtime. | CI tooling | CI |
| 4 | Peer Review. | Development team | Development |
| 5 | Merge approved. | Development team | Development |
| 6 | Committed to main branch. | Development team | Development |
| 7 | All tests run (including linting, security, code quality, accessibility, etc) | CI tooling | CI |
| 8 | Artefacts built. | CI tooling | CI |
| 9 | Deployment of artefacts on live-like preprod environment | CI tooling | CI |
| 10 | New preprod leg built / idle leg released to. | CI tooling | CI |
| 11 | Initial smoke tests run | CI tooling | CI |
| 12 | Switch traffic to new preprod leg. | CI tooling | CI |
| a | Run required pre-release performance tests / smoke tests / soak tests. | CI tooling | CI |
| b | Monitoring | CI tooling | CI |
| c | Testing period complete. | CI tooling | CI |
| 13 | Confirmation that there are no issues, ready to deploy to production. | CI tooling | CI |
| 14 | Ensure RFCs have been approved | CI tooling | CI |
| 15 | Confirmation that all traffic is currently being processed by one production leg.
| 16 | New production leg built / idle leg released to. | CI tooling | CI |
| 17 | Initial smoke tests run. | CI tooling | CI |
| 18 | Traffic is migrated to new leg. | CI tooling | CI |
| a | Monitoring occurs. | CI tooling | CI |
| b | Further smoke tests run in parallel with monitoring. | CI tooling | CI |
| c | Soak period started. | CI tooling | CI |
| d | Monitoring continues. | CI tooling | CI |
| e | Soak period complete. | CI tooling | CI |
| 19 | Release is deployed to second production leg. | CI tooling | CI |
| 20 | Initial smoke tests run. | CI tooling | CI |
| 21 | Traffic is migrated to second production leg. | CI tooling | CI |
| a | Monitoring occurs. | CI tooling | CI |
| b | Further smoke tests run in parallel with monitoring. | CI tooling | CI |
| c | Soak period started. | CI tooling | CI |
| d | Monitoring continues. | CI tooling | CI |
| e | Soak period complete. | CI tooling | CI |
| 22 | Release is marked as successful. Update RFC | CI tooling | CI |

### Failure mode

If initial smoke tests fail OR monitoring identifies increased failures / other indicator OR Further smoke tests fail:

1. Traffic is migrated back to previously healthy leg.
1. Release is marked as failed.

### Game days and chaos testing

Development teams should look at implementing regular game days to cover how their system and their teams handle failures, these game days should consider the release and deployment process as this is a key window for issues to arise in and can complicate investigations due to the impact of the change being deployed. Teams should also explore and implement [Chaos Engineering](../practices/testing.md#other-tools-to-consider) techniques.
