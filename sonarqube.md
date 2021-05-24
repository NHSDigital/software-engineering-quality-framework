# Sonarqube
SonarQube® is an automatic code review tool to detect bugs, vulnerabilities, and code smells in your code. It can integrate with your existing workflow to enable continuous code inspection across your project branches and pull requests.

## Benifits of SonarQube

SonarQube gives you the tools you need to write clean and safe code:

- SonarLint – SonarLint is a companion product that works in your editor giving immediate feedback so you can catch and fix issues before they get to the repository.
- Quality Gate – The Quality Gate lets you know if your project is ready for production.
- Clean as You Code – Clean as You Code is an approach to code quality that eliminates a lot of the challenges that come with traditional approaches. As a developer, you focus on maintaining high standards and taking responsibility specifically in the New Code you're working on.
- Issues – SonarQube raises issues whenever a piece of your code breaks a coding rule, whether it's an error that will break your code (bug), a point in your code open to attack (vulnerability), or a maintainability issue (code smell).
- Security Hotspots – SonarQube highlights security-sensitive pieces of code that need to be reviewed. Upon review, you'll either find there is no threat or you need to apply a fix to secure the code.

# Profile
Quality Profiles are a core component of SonarQube, since they are where you define sets of Rules that when violated should raise issues on your codebase (example: Methods should not have a Cognitive Complexity higher than 15). Quality Profiles are defined for individual languages.

While it's recommended to have as few Quality Profiles as possible to ensure consistency across projects, you can define as many Quality Profiles as are necessary to fit your specific needs.

The Sonar way Quality Profiles are a good starting-point as you begin analyzing code, and they start out as the default Quality Profiles for each language.

# Rules
SonarQube executes rules on source code to generate issues. There are four types of rules:

- Code Smell (Maintainability domain)
- Bug (Reliability domain)
- Vulnerability (Security domain)
- Security Hotspot (Security domain)

# Quality Gate

Quality Gates enforce a quality policy in your organization by answering one question: is my project ready for release?

To answer this question, you define a set of conditions against which projects are measured. For example:

No new blocker issues
Code coverage on new code greater than 80%

Ensuring code quality of “new” code while fixing existing ones is one good way to maintain a good codebase over time. The Quality Gate facilitates setting up rules for validating every new code added to the codebase on subsequent analysis.



## Setup default quality gates
By default, SonarQube provides basic quality gate called sonarway with folloing metrics.

- The coverage on new code is less than 80%
- Percentage of duplicated lines on new code is greater than 3
- Maintainability, reliability or security rating is worse than A

## Configuring CI pipeline
Making SonarQube part of a Continuous Integration process is possible. This will automatically fail the build if the code analysis did not satisfy the Quality Gate condition.
 
