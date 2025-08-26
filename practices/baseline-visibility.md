# Baseline Visibility

## Collaborating

This repository is part of the [NHSDigital GitHub Organisation](https://github.com/NHSDigital), which forms part of a wider [Enterprise](https://docs.github.com/en/enterprise-cloud@latest/admin/overview/about-github-for-enterprises). To enable effective collaboration between members of the NHSDigital organisation the [base permissions](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles/setting-base-permissions-for-an-organization) for repositories should be set to `No Permissions`, and visibility of Internal repositories is limited to members of the organisation. This will mean that individual members will not be able to view Private repository source code  unless granted specific permissions. All members should be invited to the `everyone` team. This grants access to Internal repositories while keeping Private repository access constrained.

As the organisation is part of the Enterprise there are other Organisations. Members of these other Organisations have read access to [Internal](./baseline-visibility.md#internal-repositories) repositories.

## Contributing

With a baseline of `No Permissions` on a repository and as a member of the `everyone` team, members of the Organisation can view the source code of Public and Internal repositories and Private repositories that they have explicit read permissions for. They might then be able to identify improvements to this code. Each repository should contain a [CONTRIBUTING.md](../CONTRIBUTING.md) to describe how both team members and members from the wider organisation can contribute to the repository. Contributions to repositories are welcomed and should be encouraged.

## Code Owners

Each repository should include a [CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners) file in one of the [recommended locations](https://graphite.dev/guides/in-depth-guide-github-codeowners#creating-and-locating-your-codeowners-file). [Branch protections](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners) must be in place to ensure that any Pull Requests are approved by users listed in the CODEOWNERS file. This ensures that any code changes are approved by appropriate members the teams that own and are responsible for the code and any downstream services that depend upon it.

The presence of the CODEOWNERS file alows organisation members to identify who to contact should they have any questions about the code.

Teams can be listed as CODEOWNERS, but secret teams should not be used.  Otherwise potential contributors wouldn't be able to identify who the codeowners are.

## Internal Repositories

Non-public repositories can be created of the `Internal` type. All members of the Enterprise can view these repositories. This will include users who do not have direct access to the individual Organisation but who are members of the Enterprise.
