# SonarQube

SonarQube® is an automatic code review tool to detect bugs, vulnerabilities, and code smells in your code. It can integrate with your existing workflow to enable continuous code inspection across your project branches and pull requests.

## Benefits of SonarQube

SonarQube gives you the tools you need to write clean and safe code:

- SonarLint – SonarLint is a companion product that works in your editor giving immediate feedback so you can catch and fix issues before they get to the repository.
- Quality Gate – The Quality Gate lets you know if your project is ready for production.
- Clean as You Code – Clean as You Code is an approach to code quality that eliminates a lot of the challenges that come with traditional approaches. As a developer, you focus on maintaining high standards and taking responsibility specifically in the New Code you're working on.
- Issues – SonarQube raises issues whenever a piece of your code breaks a coding rule, whether it's an error that will break your code (bug), a point in your code open to attack (vulnerability), or a maintainability issue (code smell).
- Security Hotspots – SonarQube highlights security-sensitive pieces of code that need to be reviewed. Upon review, you'll either find there is no threat or you need to apply a fix to secure the code.
- Raises "smells". It knows _something_ looks odd, and suggests a fix (only suggests!). Your team can then look at the bigger picture around that code, and fix the smells in whichever way is best.
- Dependency vulnerability scanning - provided by the [dependency-check-maven plugin](dependency-check-maven/README.md)
- Many other available plugins

## Best Practices for using SonarQube

1. Use the default SonarQube rulesets\
For most languages / frameworks, SonarQube provides out-of-the-box default rulesets. The benefit is that these are automatically patched whenever SonarQube is: new rules are added over time, out-dated rules are removed. They constantly represent best-practices for that language.
If you create your own rulesets, they will not be automatically updated.

2. Use the SonarWay default Quality Gates\
As above, these are auto-updated by SonarQube over time.
At time of writing, the current conditions are:

    | Metric | Operator | Value |
    | ------ | -------- | ----- |
    | Coverage | is less than | 80.0% |
    |Duplicated Lines (%)|is greater than|3.0%
    |Maintainability Rating|is worse than|A
    |Reliability Rating|is worse than|A
    |Security Hotspots Reviewed|is less than|100%
    |Security Rating|is worse than|A

3. For legacy code, use two sets of gateways\
If working with legacy software, you might need to create two sets of gateways and rulesets. One for new code ("The entire contents of any file that was changed as part of this commit."), and another that covers **all** code (new and legacy).
This approach facilitates getting new code right, without having to instantly fix legacy code.

## Configuring CI pipeline

Making SonarQube part of a Continuous Integration process is recommended: a build should fail if the code analysis did not satisfy the Quality Gate condition (see [Quality Checks](../quality-checks.md)).
Bear in mind that SonarQube analyses projects asyncronously. So your build will need to wait for SonarQube to finish. SonarQube provides a REST API that you can poll to see whether analysis has finished, and to obtain the final result.

## FAQs

### SonarQube is going to add weeks to my workload

Initially, yes, it might. Going forwards though, we should see fewer things being picked up by SonarQube. This is because these coding standards will become embedded in the team's heads: encouraging best practices before they've written a line of code.
SonarQube can then also act as a guide for new people joining: this is how we write code: these are our standards.
Also remember that, for legacy code, you can use a separate gateway to allow lower standards while you gradually bring that legacy code up to scratch. You can also use refactoring techniques to - for example - extract functionality from troublesome classes and put it somewhere else that can easily be refactored.

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

The idea of SonarQube isn't to unquestioningly implement every individual suggested code change, just to get the build to pass. Instead, we should use these suggestions, especially where we have a concentration of suggestions in one area of the code, to consider if there is something bigger that we need to address to improve our code.

### Why these rules?

The default sonar rules are established industry standards, crafted by experts, and a really good place to start.
If all teams use them, it will breed familiarity across individuals and teams.
They are also updated by SonarQube releases, which means they won't get "stale" as new language versions are released, or as industry best-practices change over time.
