# Baseline Visibility

## Collaborating

This repository is part of the [NHSDigital GitHub Organisation](https://github.com/NHSDigital), this organisation in turn forms part of a wider [Enterprise](https://docs.github.com/en/enterprise-cloud@latest/admin/overview/about-github-for-enterprises). To enable effective collaboration between members of the NHSDigital organisation the [base permissions](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles/setting-base-permissions-for-an-organization) for all repositories should be set to `Read`. This will mean that individual members will be able to view source code from across the organisation whether it is Public or Private.

As the organisation is part of the Enterprise there are other Organisations, for members of these organisations it is possible to provide access to view Source Code in this organisation without the need to invite users into this org by setting the visibility for the repository to [Internal](./baseline-visibility.md#internal-repositories).

## Contributing

With these permissions members can view the source code, they might then be able to identify improvements to this code. Each repository should contain a [CONTRIBUTING.md](../CONTRIBUTING.md) to describe how both team members and members from the wider organisation can contribute to the repository. Contributions to repositories are welcomed and should be encouraged.

## Code Owners

Each repository should include a [CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners) file in the root of the project. And [branch protections](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners) must be in place to ensure that any Pull Requests are approved by users listed in the codeowners file. This ensures that any code changes are approved by appropriate members of staff from the teams that own and are responsible for the code and any downstream services that depend upon it.

Teams can be listed as CODEOWNERS - but secret teams should not be used so that individual members of the organisation can identify who the codeowners are.

The presence of the CodeOwners file will also mean that organisation members can identify who to contact should they have any questions about the code.

## Internal Repositories

Private repositories can be created at the `Internal` type. This will mean that all members of the "Enterprise" can view these repositories. Note that this will include users who do not have direct access to the NHSDigital Organisation.
