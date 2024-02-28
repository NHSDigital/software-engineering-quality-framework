## Dependency scanning with SonarQube
SonarQube empowers all developers to write cleaner and safer code. SonarQube provides clear remediation guidance for developers to understand and fix issues and for teams overall to deliver better, safer software.

<!--Security Vulnerabilities require immediate action. SonarQube provides detailed issue descriptions and code highlights that explain why your code is at risk.-->

Sonarqube offers a plugin called Dependency-Check, a utility that attempts to detect publicly disclosed vulnerabilities contained within project dependencies. It does this by determining if there is a Common Platform Enumeration (CPE) identifier for a given dependency. If found, it will generate a report linking to the associated CVE entries.

Dependency-Check supports the identification of project dependencies in a number of different languages including Java, .NET, Node.js, Ruby, and Python.


## Note

This SonarQube plugin does not perform analysis, rather, it reads existing Dependency-Check reports. Use one of the other available methods to scan project dependencies and generate the necessary JSON report which can then be consumed by this plugin. Refer to the [Dependency-Check project](https://github.com/jeremylong/DependencyCheck) for relevant [documentation](https://jeremylong.github.io/DependencyCheck/).

Is it very quick and easy to configure depenedency scanning in your azure devops pipeline.

- Install Dependency-Check plugin on SonarQube.
- In your azure build pipeline add SonarQube prepare task
- Add OWASP Dependency Check
 task. Configure the task and make sure 'Enable SonarQube Integration' option is checked.
- Save and run the pipeline.
- OWASP dependency Check task generates a report which is then uploaded to sonarqube.
- You can create a supression file for any vulnerabilities that cannot be addressed and pass it as additional arguments in OWASP dependency check task.
e.g 
>--suppression "$(Build.SourcesDirectory)/src/function/owasp-dependency-check-suppressions.xml"
