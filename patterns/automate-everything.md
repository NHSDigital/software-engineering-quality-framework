# Automate everything

## Context

* These notes are part of a broader set of [principles](../principles.md)
* See also:
    * [Continuous integration](../practices/continuous-integration.md)
    * [Testing](../practices/testing.md)
    * [Everything as code](everything-as-code.md)

## The pattern

Regularly review *every* manual process that the team performs. Automate it, but be pragmatic: choose where to invest your time. Error-prone, high impact and frequent activities are all high priorities for automation.

## Benefits

* Reliability and consistency: automated changes are highly repeatable, which makes them more reliable than performing the same steps manually.
* Resilience: automation involves representing the process in code of some sort. This means that the knowledge for how to perform the process is captured which means it cannot leak out of the team through members leaving.
* Auditability: it is easy to create a log of automated changes as they are performed. Also, by storing automation scripts in source control, changes to the process can be tracked over time (see [everything as code](everything-as-code.md)). Both of these can help diagnose any issues which occur.
* Availability: automated processes do not rely on someone being available to trigger them, they can happen whenever they need to.
* Speed: machines can typically perform actions quicker than humans and they don't get distracted or bored, so automated processes are typically quicker (though of course time is needed to automate processes initially).

## Risks

* Broken assumption: automated changes typically rely on a set of assumptions about the system being changed to be true. e.g. a certain FTP server should be accessible, the credentials should work, a certain folder should be present and so on. Automation must safely handle the case where these assumptions are not true. This will typically occur when manual changes have been made to the system and a good approach is to fail early and alert that manual intervention is required (which could consist of updating the automation scripts to account for the unexpected scenario).
* Not automating enough: a naive time-based cost-benefit analysis can lead teams to deprioritise automation of tasks which are considered quick and easy to perform manually, missing the more important other benefits outlined above.
* Automating the wrong thing: it's often better to redesign a process rather than blindly automating a manual process. e.g. people are good at handling unpredictable situations and interacting with graphical interfaces, while automation tools are not. Automatic processes will work better if the quality and predictability of user input is ensured at entry time, e.g. using form validation. Automated processes are easier to implement using programmatic APIs than interfaces designed for humans.

## Examples &mdash; what to automate

* Process to rebuild a developer laptop
* Stress testing / Soak testing
* Manually telling someone that the build is ready for testing / ready for a review
* Manually updating a release log
* Automated [tests](../practices/testing.md).
* Automated [security](../practices/security.md) verification.
* Automated [governance](governance-side-effect.md).
* Hooks to [enforce code formatting](enforce-code-formatting.md).

## Examples &mdash; how to automate

Some automation is highly managed and is purely declarative. e.g. VM or container auto scaling in cloud platforms can typically be achieved without the need to write any code: the platform implements scaling based on specified rules.

Programmatic automation by contrast typically involves writing code and involves the use of **orchestrators** such as CI tools (e.g. Jenkins, Circle CI), AWS Step Functions or Lambda triggers and **runners** which do the actual work (e.g. bash or Python scripts). The orchestration and runner logic should all be represented in code with everything that entails (see [everything as code](everything-as-code.md)).
