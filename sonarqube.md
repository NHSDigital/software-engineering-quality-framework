# Sonarqube
SonarQube® is an automatic code review tool to detect bugs, vulnerabilities, and code smells in your code. It can integrate with your existing workflow to enable continuous code inspection across your project branches and pull requests.

## Benefits of SonarQube
SonarQube gives you the tools you need to write clean and safe code:

- SonarLint – SonarLint is a companion product that works in your editor giving immediate feedback so you can catch and fix issues before they get to the repository.
- Quality Gate – The Quality Gate lets you know if your project is ready for production.
- Clean as You Code – Clean as You Code is an approach to code quality that eliminates a lot of the challenges that come with traditional approaches. As a developer, you focus on maintaining high standards and taking responsibility specifically in the New Code you're working on.
- Issues – SonarQube raises issues whenever a piece of your code breaks a coding rule, whether it's an error that will break your code (bug), a point in your code open to attack (vulnerability), or a maintainability issue (code smell).
- Security Hotspots – SonarQube highlights security-sensitive pieces of code that need to be reviewed. Upon review, you'll either find there is no threat or you need to apply a fix to secure the code.
- Raises "smells". It knows _something_ looks odd, and suggests a fix (only suggests!). Your team can then look at the bigger picture around that code, and fix the smells in whichever way is best.

# Profile
Quality Profiles are a core component of SonarQube, since they are where you define sets of Rules that when violated should raise issues on your codebase (example: Methods should not have a Cognitive Complexity higher than 15). Quality Profiles are defined for individual languages.

While it's recommended to have as few Quality Profiles as possible to ensure consistency across projects, you can define as many Quality Profiles as are necessary to fit your specific needs.

The Sonar way Quality Profiles are a good starting-point as you begin analyzing code, and they start out as the default Quality Profiles for each language, created by knowledge experts.

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
By default, SonarQube provides basic quality gate called sonarway with following metrics.

- The coverage on new code is less than 80%
- Percentage of duplicated lines on new code is greater than 3
- Maintainability, reliability or security rating is worse than A

The recommendation is that we use the Sonarqube Way for all projects. Teams will eventually diverge, but these diversions need to be closely monitored by the Tech Lead and the team.

## Configuring CI pipeline
Making SonarQube part of a Continuous Integration process is recommended: a build should fail if the code analysis did not satisfy the Quality Gate condition.



## FAQs

### SonarQube is going to add weeks to my workload!
Initially, yes, it might. Especially if you're introducing it to an existing, legacy codebase.
Going forwards though, we should see fewer things being picked up by SonarQube. This is because these coding standards will embedded in the team's heads: encouraging best practices before they've written a line of code.
SonarQube can then also act as a guide to new people joining: this is how we write code: these are our standards.

### Why should I listen to SonarQube?
You live and breathe your code every day: you're probably aware of every pitfall and quirk.
New starters won't be. 
You've probably also got used to the fact that code changes take X times longer than they could, because the code is not as maintainable as it could be.

### The suggested fix is nonsense!
SonarQube does two jobs: finds real issues; and raises "smells".
Smells only give you _suggested fixes_. You do not have to follow its suggestions. But you do have to make the build pass again!
For example: SonarQube raises 10 smells in a piece of code: tiny, annoying things. It isn't telling you to fix them. You could. And get the build passing again like that - but that's not the point.
What you - as the expert - need to do is look at the bigger picture. Why is SonarQube raising these? Does this entire class need rewriting? Does it interact with other classes properly? Do we need a properties file instead of hardcoding values? Do we need to look at error handling across the whole system? Is our code written well for reuse and testability?
What's _really_ causing those underlying issues?

The idea of SonarQube isn't to tickle a few lines of code just to get the build passing! If it's shouting about a lot of small, related issues, it probably means there’s something much bigger that you need to address!

### Why these rules?
Everyone has different standards. Agreeing is impossible. We need to impose <something>. If we impose the default SonarQube rules, it will breed familiarity across individuals, teams, even companies.




