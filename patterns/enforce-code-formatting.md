# Enforce code formatting

## Context

* These notes are part of a broader set of [principles](../principles.md)

## The pattern

Being consistent with your code formatting improves readability, and maintainability of your code base. Where consistency is enforced prior to commits being pushed this ensures that commits are cleaner and easier to manage.

## Benefits

* Reduces the need for changes to include formatting updates across non impacted code.
* Improves clarity of code.
* Enables teams to agree on formatting that is important to them up-front.

## Details

* Teams should agree on linting tools for their code.
* Teams should agree the rules around formatting for their code.
* These tools should be used to ensure that commits are not merged where code does not meet the agreed ruleset.
* Teams should implement pre-commit hooks to check developers commits and fail to push changes that do not adhere to the agreed format.
* Tools should provide useful output on failures - ideally auto formatting the code for developers to accept.
* Developers can then apply formatting changes as part of their development process.
* Teams should also employ a specific step in their CI/CD pipeline to verify that code is formatted to the agreed standards.

## Examples

* Python code formatting could use Black to enforce formatting on a repo.