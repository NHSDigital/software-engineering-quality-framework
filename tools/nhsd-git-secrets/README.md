# Git-Secrets examples
This folder comprises examples for implementing AWSLabs Git-Secrets, which is our default implementation for [secrets scanning](../../quality-checks.md). As with any default, we expect teams to resolve any caveats as they best see fit, and of course to contribute to these examples.

# Why secrets scanning
Although we might be re-stating the obvious here, there's two main goals to consistent secrets scanning:
1. Remove any secrets that may have been checked into the codebase in the past.
2. Prevent any new secrets from making it into the codebase.

Essentially, we want to avoid the NHS facing [potentially dire consequences](https://www.zdnet.com/article/data-of-243-million-brazilians-exposed-online-via-website-source-code/) due to exposure of secrets.

# How to get started
If your team isn't doing secrets scanning at all yet, the fundamental first step is to understand the current state of the art. Use the [Macbook](README-mac-workstation.md) or Windows (coming soon...) guides to set up and run Git-Secrets for a nominated team member. Run the tooling, and ascertain whether there's any immediate actions to be taken.

# Getting to green
Once you've verified there's no urgent actions on your code, the next steps towards getting to green are:
1. Ensure every team member is doing local scans. Stopping secrets before code has been committed is cheap, removing them from git history is expensive.
2. Run these same scripts as part of your deployment pipelines as a second line of defence.
