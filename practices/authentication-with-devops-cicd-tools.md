**Examples of DevOps Tools:**

- Azure DevOps - Pipelines
- GitHub - Actions
- AWS CodePipeline
- TeamCity
- Jenkins

**Identity, Authentication, and Authorization**

Secrets are the authentication details proving the identity of a user or system. Authenticated identities then have authorisation to access or use systems based on user or group privileges defined within systems.

Users need to understand what authentication secrets they need to control, where they are necessary in the CI/CD pipeline, and how they are configured, stored, and managed within the pipeline and deployed infrastructure.

Secrets are digital credentials that are used to provide identity authentication and authorise access to privileged accounts, applications, and services.

For example, users authenticate to have access to a source control system like GitHub to commit changes to a codebase, which kicks off test, build, and deployment tasks in a CI/CD pipeline in AWS CodePipeline.

Here are some other examples:

- User or auto-generated passwords
- API, GitHub tokens, and other application keys/credentials
- Hard-coded credentials in containerised applications
- SSH Keys
- Private certificates for secure communication, transmitting and receiving of data (TLS/SSL)
- Private encryption keys for systems
- System-to-system passwords

**Secrets in a CI/CD Pipeline**

Automated processes are a critical component of DevOps infrastructure. CI/CD orchestration and configuration tools such as listed above are increasingly deployed in DevOps processes to improve processes, facilitate faster deployment of software and product delivery, and provide continuous cost reduction.

However, CI/CD tools are the biggest consumers of secrets and have access to a lot of sensitive resources such as other apps and services and information like codebases and databases. As the number of secrets grows, it becomes harder to store, transmit, and audit secrets securely.

Furthermore, secrets aren't just for authentication between tools. Often, secrets need to be provided as part of the build and deployment process so that deployed resources have access. This is particularly important in hybrid cloud and microservices deployments, and with the automated scaling capabilities of tools like Kubernetes.

**Common Risks to Secrets**

Tools such as above interface with other systems and applications throughout DevOps environments, and there is the danger of exposed secrets in the clear in CI/CD config files.

Configurability and use of plugins makes it challenging to securely determine who can use the pipeline/action, what it is allowed to do, and where it can deploy its artefacts to.

Tools communicate with a multiple applications and systems across environments. Secrets can end up in configuration files. Most tools include a central credentials store to manage the credentials needed for each pipeline. The pipelines/actions can access these credentials at runtime, and the server obscures their usage in the output of each job.

This creates the challenge of securing access to critical secrets such as passwords, source control and artefact deployment. This causes a security risk if users leave tools consoles in an insecure state within development environments.

If users store passwords within the tool, they may not be visible from within the web console, but are able to be extracted from the system itself.

Any admin users with Job/Configure permissions have the opportunity to run any executable on the tool agents and request any set of credentials defined in their scope (global or otherwise) to be injected to agents using the credentials binding plugin.

This exposes all credentials in the global scope to any pipeline and any job admin user. Thus, an attacker can shift from low privilege to highly privileged with access to AWS secret keys, passwords, and git credentials.

These risks are not exclusive to a single tool. Any system that allows user-defined build processes and the use of credentials in build processes faces the same potential issue of allowing the exposure of credentials. We need to protect and be confident in the artefacts produced from the CI/CD.

Compromised secrets means someone could make unwanted changes or leak information. Furthermore, these secrets may be insecurely hard-coded or store insecure configuration files, which jeopardises security for the entire automation process.

While tools, platforms, and infrastructure may have their own built-in capability to secure secrets, these may lack interoperability, leading to siloed security efforts, making it difficult to track, manage, and audit security effectiveness.

**Best Practices for CI/CD Security**

The first steps for securing CI/CD pipelines include locking down configuration managers, systems that host repositories, and the build servers. The pipeline should be monitored from end to end with access control across the entire toolchain. Scripted builds need to be scanned for vulnerabilities, and source code needs to be regularly monitored for vulnerabilities prior to app deployment to production.

The security of secrets needs to apply both during transit and at rest. Best practices include the following:

- Remove hardcoded secrets from CI/CD config files.
- Have rigorous security parameters, such as one-time passwords, for secrets regarding more sensitive tools and systems.
- Distribute secrets among pipelines/actions to reduce the potential attack target of each file.
- Use password managers, and rotate passwords after each use.
- Know who has access to what. Whether it's role-based, time-based, or task-based, there should be a clear repository of access management. Another option to consider is segmenting secrets based on levels of access.
- Machine identity is critical to secure non-human access in containers. Typically, an authenticator certifies that the client run-time container attributes of the requesting container match the native characteristics of the valid container. Once authenticated, the container can access multiple resources based on predefined role-based access control policies. You should destroy containers and VMs after use.
- Ensure secrets are not inadvertently passed on during builds for pull requests via your CI/CD pipelines.
- Deploy the practice of least privilege: Give access only to secrets that are requisite. Besides user access, least privilege also applies to applications, systems, or connected devices that require privileges or permissions to perform tasks. You should regularly audit levels of access to maintain the level of least privilege.

**Tool Use Cases**

**GitHub Actions with AWS CodeBuild**

Use service user account (inform CSOC [csoc@nhs.net](mailto:csoc@nhs.net) to add user account to exception rule to prevent false positives being alerted):

1. Create a service user with start CodeBuild job only permissions
2. Store Key+Secret access key in GitHub vault
3. GitHub Action invokes the CodeBuild job.

**GitHub**

Use personal access tokens:

1. In the upper-right corner of any page, click your profile photo, then click  **Settings**.

2. In the left sidebar, click  **Developer settings**. Then click  **Personal access tokens**.

3. Click  **Generate new token**.

4. Give your token a descriptive name.

5. Give your token an expiration, select the  **Expiration**  drop-down menu, then click a default or use the calendar picker.

6. Select the scopes, or permissions, you'd like to grant this token. To use your token to access repositories from the command line, select  **repo**.

7. Click  **Generate token**.

8. Use token with GitHub Actions

**Azure DevOps**

Use personal access token:

1. Login in Azure DevOps
2. Go to User Settings (top-right beside help)
3. Click Personal access tokens
4. Click New Token
5. Configure Name and Expiration
6. Ensure Scopes is set to Custom defined
7. Check Packaging \> Read
8. Click Create
9. Add the new token to your password manager

In addition, use Self-Hosted Agents which utilise an Azure NAT Gateway and public IP address to provide a single outbound IP for the agents.

In Azure DevOps, connect to the Scale Sets using the Agent Pools section in Organization Settings.
