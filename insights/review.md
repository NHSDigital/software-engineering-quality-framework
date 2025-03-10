# Engineering quality review tool

- [Engineering quality review tool](#engineering-quality-review-tool)
  - [Purpose](#purpose)
  - [Metrics](#metrics)
  - [Scores and actions](#scores-and-actions)
    - [Example](#example)
    - [Team](#team)
      - [1. Mission](#1-mission)
      - [2. Plan](#2-plan)
      - [3. Fast, reliable and safe delivery](#3-fast-reliable-and-safe-delivery)
      - [4. Fun](#4-fun)
      - [5. Pawns or players](#5-pawns-or-players)
      - [6. Outside support](#6-outside-support)
      - [7. Skills and knowledge](#7-skills-and-knowledge)
    - [Individual component or system](#individual-component-or-system)
      - [8. Healthy code base](#8-healthy-code-base)
      - [9. Testing](#9-testing)
      - [10. Tech and architecture](#10-tech-and-architecture)
      - [11. Easy and safe to release](#11-easy-and-safe-to-release)
      - [12. Security and compliance](#12-security-and-compliance)
      - [13. Operability and live support](#13-operability-and-live-support)
  - [How to facilitate](#how-to-facilitate)
    - [Facilitator responsibilities](#facilitator-responsibilities)
    - [Preparation](#preparation)
    - [Facilitator tips](#facilitator-tips)

This is part of a broader [quality framework](../README.md)

## Purpose

This tool aims to:

- Help teams understand what "good" looks like &mdash; and to contribute to that shared understanding.
- Measure themselves against this shared standard.
- Identify and prioritise improvement work.
- Escalate and ask for help in driving improvements.

This is a **self** assessment review:

- The review is carried out **by** the team, not "done to" the team.
- The emphasis is on **discussion and action**, not on the scores.
- Scores help the team focus attention on where to concentrate improvement work.
- Scores can help teams communicate and escalate issues outside the team.
- Scores cannot be compared between teams, but they can help spot common issues which would benefit from coordinated effort between and across teams.
- This is for use by *whole teams*, which means everyone involved in the delivery & operation of the product, not defined by organisation boundaries (for example if specialisms such as service management and cyber are based in a separate area of the organisation, they are still part of the team and should be included in the review session)

## Metrics

These reviews are intentionally subjective and open-ended, unlike [metrics](metrics.md) which are prescriptive and specific. Both of these things should be considered together, so these reviews should take the relevant [metrics](metrics.md) into account.

## Scores and actions

Focus on one area at a time, e.g. mission, plan.

As a team, assign a 1–5 score as below. You could use "planning poker" style blind voting.

1. Major problems to fix or work to do.
1. Significant issues, worries or gaps. A key area for improvement.
1. Some issues or gaps which need focus to improve.
1. Not a primary focus for improvement. A few rough edges, but no major concerns.
1. May not be perfect, but we hold this as an example of how to do things well.

Discuss why that score and not higher or lower. Pay particular attention when there are large differences in scoring between individuals. These are a great opportunity to build more consensus and shared understanding.

Finally (and most importantly) identify actions to move the score upward.

### Example

| Area             | Score | Comments                                      | Actions                                                                                                                                                   |
| :--------------- | :---- | :-------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Mission          | 2     | We don't validate our user needs              | Identify customers to participate in focus groups                                                                                                         |
| Plan             | 3     | Plan is a bit out of date and feature focused | Begin regular fortnightly backlog refinement and roadmap refresh session.<br>One off review to make sure operational readiness is adequately represented. |
| Pawns or players | 5     | We have great autonomy                        | No action                                                                                                                                                 |

### Team

#### 1. Mission

- We have clear goals.
- We know the metrics which will measure success and how they will be measured.
- User needs are well understood and validated through user research.
- Non-functional requirements are understood and based on user needs.

#### 2. Plan

- We have a plan which is visible to all of us.
- The plan is at the right level and shows what we expect to be delivered each sprint/month &mdash; usually 2–5 items in each increment.
- It is up to date and complete.
- We have regular planning sessions.
  - They involve all the people who are needed.
  - They are efficient and effective.
- It changes when it should but is stable enough.
- It gives our stakeholders a clear forecast of what is most likely to happen over the coming time periods.
- It makes sure we work on the right things first and helps us predict and avoid issues.
- Functionality is delivered in [thin vertical slices](https://docs.google.com/document/u/1/d/1TCuuu-8Mm14oxsOnlk8DqfZAA1cvtYu9WGv67Yj_sSk/pub), starting by building a [steel thread](https://www.agiledevelopment.org/agile-talk/111-defining-acceptance-criteria-using-the-steel-thread-concept) / [walking skeleton](https://www.henricodolfing.com/2018/04/start-your-project-with-walking-skeleton.html)
- Risky items and dependencies are clearly indicated and work to reduce risk is prioritised.
- The plan gets the right balance between delivering features and operational aspects.
- We track risks, issues, assumptions and dependencies ('RAID') and work creatively to resolve them.
- We keep a log of key technical and product decisions and who approved them, e.g. by using the [Any Decision Record template](../any-decision-record-template.md).

#### 3. Fast, reliable and safe delivery

- We work well together to keep the work flowing.
- We have a defined process which we all stick to.
- Our process helps us deliver high quality work quickly.
- We have stand up every day with the whole team.
  - It keeps us aligned and working well as a team.
  - It helps us share and resolve impediments.
- All our code is stored in source control (e.g. git).
  - We practice [trunk-based development](https://trunkbaseddevelopment.com/) using short-lived feature branches off the main branch.
  - All code must be reviewed before it is merged.
  - Tests must pass before code is merged.
- We can see when the build has broken or tests are failing and we fix them before carrying on.
- Our definition of "done" is ready to deploy to production.
- We explicitly limit work in progress (WIP).
- Our lead time is typically two days or less.
  - (Lead time = time from picking an item up to it being done.)

#### 4. Fun

- The team is a fun place to be every day.
- We have great team spirit and help each other out.
- We give each other honest feedback.
- We learn something every day.
- We have regular retrospectives.
  - We look forward to them and they drive valuable improvements.

#### 5. Pawns or players

- As a team, we are in control of our destiny!
- We are given problems to solve, not just solutions to implement.
- We decide how to build it.

#### 6. Outside support

- We always get great support and help from outside the team when we ask for it!
- We are listened to and our ideas are used to improve the organisation.

#### 7. Skills and knowledge

- We have the skills and knowledge we need.
  - We are familiar with the tech in use and know how to use it well.
  - We know the codebase and are comfortable making changes in it.
  - We know how to operate the live system reliably and diagnose and fix things when they break.
  - We have the skills and knowledge for what we will be doing next.
- Skills and knowledge are well spread between team members.
- The onboarding process for new team members is simple and straightforward.

### Individual component or system

You may wish to score each individual component or system separately for these aspects.
> Identify components based on natural seams in the system. Ultimately, the aim is to make it easy to decide what the appropriate score is for each "component". If you can"t decide between a low and high score for an aspect then this may indicate that component should be broken down to allow finer grained scoring.
>
> Example components:
>
> - React web UI
> - Individual APIs or services
> - The cloud platform
> - The CI/CD system

#### 8. Healthy code base

- We're proud of the quality of our code!
- It is clean, easy to read, well structured and safe to work with.

#### 9. Testing

- We have great test coverage.
- Testing is everyone's responsibility and test is a first-class concern.
- We support all team members to practice good testing, including by holding no-blame sessions to discuss any automation tests we should have added, and what we can learn from having missed them initially.
- We build code for testability.
- Tests are part of our standard peer-review process.
- Repetitive tests are automated.
- Testing is considered before each work item is started and throughout its delivery.
- We use the right mix of testing techniques including automated checks and exploratory testing.
- We consider whether the system genuinely meets user needs, rather than just following specifications blindly.
- We have code-level unit and integration tests, and maybe practice behaviour-driven development.
- We have component, integration and whole-system tests which interact with a running system.
- Our automated checks focus on individual components and the contracts between them, not on testing the whole system together.
- We use stubs to insulate our tests from other components and systems &mdash; always for automated tests, sometimes for exploratory testing.
- We understand user needs and non-functional requirements and our tests prove they are being met.
  - e.g. accessibility, browser compatibility, performance, capacity, resilience.
- Our components have versioned APIs.
- Breaking changes are detected and clearly indicated.
  - e.g. using Consumer-Driven Contract testing and semantic versioning.
- We use the right combination of automatically generated test data and anonymised live data and our data has the right properties and scale.

#### 10. Tech and architecture

- We use modern technologies which work well for us.
  - e.g. serverless or ephemeral/immutable instances ([cattle, not pets](http://cloudscaling.com/blog/cloud-computing/the-history-of-pets-vs-cattle)).
- We enjoy working with them and they support fast, reliable and safe delivery.
- The tech and architecture make testing, local development and live operations easy.
- The architecture is clean.
  - Our system is built as a set of independent services/components where appropriate (see [Architect for Flow](../patterns/architect-for-flow.md)).

#### 11. Easy and safe to release

- It is easy and straightforward to release a change to production.
- We can release on demand, typically multiple times per day.
- Our deployments are automated, including infrastructure and everything needed to build an environment from scratch.
- Every code merge triggers the creation of a potentially releasable build artifact.
  - That same artifact is deployed to each environment (e.g. dev, test, prod) rather than a new build being done for each.
- We can deploy any recent version.
- Our test and production environments are all in a known state, including configuration parameters.
- The CI/CD system has secure access control and credentials to deploy to each environment are handled securely.
- We use blue-green/canary deployments to safely verify each deployment before fully switching over to the new version.
- Our non-prod environments are cleared down automatically when they're no longer needed.

#### 12. Security and compliance

- We are confident our systems are secure.
- We model threats and design systems to be secure.
- Security is baked into our software delivery process.
  - e.g. in analysis, coding and testing.
- We understand typical vulnerabilities and how to guard against them.
  - e.g. OWASP Top Ten.
- We understand the sensitivity of the data we process and handle it accordingly.
- We know which regulations apply, and ensure we meet their requirements.
  - e.g. GDPR, PCI, ISO.
- Data is encrypted in transit and at rest where needed.
- Sensitive data is not leaked via application logs.
- We use role based access control with minimum privileges for internal tools and the systems we build.
- Identity and access management is modern and secure.
  - e.g. OAuth/OIDC with MFA.
- Security is treated as an unspoken user need and functional tests ensure security measures work as intended.
- Automated checks are in place for vulnerabilities in dependencies such as code libraries and container or VM base images.
- There is strong separation (e.g. different AWS accounts) for test and production systems.
- Humans don't have write access to production, except via time-limited "break-glass" permissions.
- We keep the versions of technology in our system up to date.

#### 13. Operability and live support

- We consider operations from day one and design the system to be easy to operate.
- We include operability features throughout delivery, treating them as user needs of the support team.
  - e.g. monitoring and log aggregation.
- Our systems are reliable.
- We have great insight into how live systems are functioning.
  - e.g. metrics dashboards, request tracing and application logs.
- We detect potential issues and take action to prevent them.
  - e.g. TLS certificate expiry, hitting quota limits.
- We detect incidents before our users tell us about them and have a slick process for resolving them.
- We classify incidents and work to agreed protocols according to the Service Level Agreement (SLA) for each.
- We learn from incidents using blameless postmortems.
- We use Service Level Objectives (SLOs) and error budgets to balance speed of change with operational reliability.
- We design for failure and we're confident our service will self-heal from most issues.
- Our components are immutable: every deployment creates new instances which replace the old ones.
- We can see what is currently deployed in each environment, including configuration and feature flags, and can see the history of changes.
- Our infrastructure scales automatically.
- We have clear visibility of our environment costs, and we regularly check for waste.

## How to facilitate

Reviews using this framework are done by the team, either as a whole or by a smaller set of representatives. As a guide, 6&ndash;8 is a good maximum number of people for a session. The scope of the review should be small enough so that a single set of scores and actions appropriately represent the situation for the [Team](#team) aspects.

Good facilitation can help teams get the most out of the review and it is recommended that all reviews should include an outside facilitator familiar with the framework. Because of the breadth and depth of the review, facilitation is best done by someone who has a broad background in both technical and delivery aspects. This helps them clarify and explain aspects of the review for the team and provide examples from their experience, and allows them to delve into areas in more detail when required.

### Facilitator responsibilities

- Ensure the session has the right people in it - see note about about "whole team" not being defined by organisation structures.
- Ensure all participants understand the [purpose](#purpose) of the review.
- Ensure a full and accurate review is done, considering all aspects.
- Ensure actions are identified and recorded.

### Preparation

- Recommended group size is 3&ndash;8 team members for each session.
- Recommended duration is 3&ndash;4 hours, either in one block with breaks or in multiple sessions (but aim to avoid long gaps between sessions).
- Ask a member of the Software Engineering Quality Assessments team (currently Andrew Blundell, Daniel Stefanuik, David Lavender, Sean Craig, Nick Sparks, Ezequiel Gomez) to create a blank spreadsheet for the review from the [template](review-template.xlsx). This will be stored centrally and shared with the team.
- Work with a member of the team to fill in the *Project* and *What's it do* fields before the session. This is typically uncontroversial and saves time in the session.
- To save time, fill in the list of participants before the session, but verify and update as necessary at the start of the session.
- Be ready for the session with the review spreadsheet and this document open such that both can easily be seen by participants by sharing your screen (assuming the review is not being held in person).

### Facilitator tips

- It's important to set the right tone. Some teams may understandably be wary of "being assessed", particularly because the process includes an outside facilitator. It's essential that they feel safe to make an honest appraisal. Emphasise that this tool is just a way of helping teams identify how to best drive continuous improvement &mdash; a bit like a "structured retrospective".
- Remember (and remind the team) that this framework is continually evolving and "open source". Encourage them to suggest ways it can be improved and raise pull requests. As well as being a useful way to drive improvement of the framework, this encourages the idea that it is not set in stone and decreed from on high, which can build trust and engagement.
- Help the team understand and compare where they are just now with what genuinely excellent looks like. The notes under each section try to describe what good looks like, and the [principles](../principles.md), patterns and practices go into more detail. Help them trace the path to excellence by starting with achievable changes and working over time to more significant changes if relevant.
- Be intimately familiar with the sections of the review and the supporting [principles](../principles.md), patterns and practices. Try to keep conversation focused around the topic for each section, mentioning which section will cover the point being raised when suggesting that discussion be deferred.
- Consider running an "ice breaker" to get the team engaged and talking in the session. This can help to reduce confirmation bias with only the more vocal members of the team contributing to the session.
- Work through the review section by section. For each, briefly outline the scope and pick out a few key points from the list of what "good" looks like, then invite the group to describe how things work for them. Keep conversation and questioning open to start with and let the conversation be led by the team. Ask specific questions to fill in any gaps based on the points under each section. Identify any actions which come up and record these. Try to keep the conversation relevant and focused &mdash; there is a lot to go through.
- Once the team has discussed the points for the section, it's time to score. A good way to do this is using "planning poker" style blind voting, which can be easily done by holding up 1 to 5 fingers. Discuss any differences and use these as a lever to bring some of the quieter team members into the conversation. Agree on a single score for the team which is recorded. Refer to the definitions of each score at the bottom of the review sheet. While emphasising that the score is not the most important part of the process, advise the team when it feels like they are being too harsh or too soft on scoring. Accurate scoring will more clearly focus attention on the right areas.
- Consider going straight to scoring for some sections before the team discussion. This is a useful way to engage some of the more quiet members of the team, e.g. ask them to explain why they have put forward a score that is higher or lower than the team consensus. This is a great way to bring them into the coversation.
- Encourage the team to identify what action could improve the score (especially if 3 or lower) and record these. Make sure the team is happy with the wording you use for the action.
- At the end of the session work through the actions with the team to come up with the top 3 actions based on priority. Add these to the "Top Actions" section of the review sheet.
- Wrap up the session by sharing a link (with editing enabled) to the spreadsheet with the team. The person who generated the blank sheet will have created this link at the time and have shared it with you. The review is owned by the team and they should feel free to refer to it and tweak the scores and actions over time.
