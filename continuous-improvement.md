# Continuous improvement

Continuous improvement is the practice of iteratively reviewing processes and impediments and making incremental changes to reduce waste and increase quality.

## Quick start

This document provides some theory and practical advice on practising continuous improvement. But you don’t need a lot of process to get going. There will almost certainly be problems people are already aware of which provide a great starting point for improvement work.

Set up regular retrospectives with the whole team and make a commitment to spend some time acting on the things which are uncovered. Don’t bite off more than you can chew: pick one or two changes which you think will be achievable in the next Sprint/iteration.

Set out with the intention of having this as a permanent part of how you work, iteratively checking how things are, thinking of what to do to improve things, making a small change and repeating.

> **Example**
>
> During a retrospective, the team identify that the product owner frequently identifies issues with features once they have been implemented.
>
> They consider various options, including adding more detailed requirements to stories during sprint planning, introducing a dedicated "analysis and elaboration" stage to their agile process, and showing the working software to the product owner during development for earlier feedback.
>
> They can see potential value in all three, but decide to choose one to start with, remembering that continuous improvement is an iterative process. Because the product owner is often busy and may not always be available at short notice, they decide to try adding more detailed requirements to stories during sprint planning.
>
> In teams where it is easier to get input from the product owner at short notice, they may prefer to add the "analysis and elaboration" stage instead to get the benefit of doing this analysis just in time. It's important to choose the right action for the specific scenario the team is facing.

## Improvement cycles

It is common to describe the iterative continuous improvement process as cyclical, and two common models are Plan-Do-Check-Act (PDCA) and Observe-Orient-Decide-Act (OODA).

### Plan-Do-Check-Act

The PDCA cycle attributed to Demming and Shewhart, and here adapted from  [ASQ](https://asq.org/quality-resources/continuous-improvement) has four stages which are to be performed in a continuous loop:
* **Plan**: Identify an opportunity and plan for change.
* **Do**: Implement the change on a small scale.
* **Check**: Use data to analyse the results of the change and determine whether it made a difference.
* **Act**: If the change was successful, reinforce it or implement it on a wider scale and continuously assess your results. If the change did not work, begin the cycle again &mdash; i.e. try a different approach to driving improvement in this area.

At any one time, you may have several improvement initiatives in progress.

### Observe-Orient-Decide-Act

The OODA loop was devised by John Boyd and has a similar, but slightly different structure:
* **Observe** that there is a problem.
* **Orient**: seek to understand the causes by seeing the problem in an unbiased way.
* **Decide** on your next step, typically a small experimental change.
* **Act**: make the change.
* **Observe** (again): continue round the loop repeatedly observing what the biggest problems are and focusing on tackling them iteratively.

## Benefit: Maintain and improve processes

*	Reduce waste leading to improved efficiency and productivity.
*	Higher quality and lower error rates.
*	Happier people and improved engagement, retention, and recruitment.

It takes continuous effort to maintain and evolve processes in response to challenges and changing circumstances.

## Benefit: Control technical debt

Technical debt arises due to processes or practices in the past, but is having an ongoing impact on the present.

Tech debt:
*	can lead to bugs and loss of reliability.
*	means changes take longer.
*	the time to make change is more unpredictable.
*	causes dissatisfaction and disengagement in the team.

Without sustained effort these all get worse over time, reducing capacity for delivering features. If little or no tech debt improvement work is done, delivery may initially be faster, but over time it becomes progressively slower and less predictable.

## Identifying improvement opportunities

Regular team retrospectives are an effective way to identify improvement opportunities and actions. Another potential source are periodic reviews using tools such as the the [AWS](https://aws.amazon.com/architecture/well-architected/) or [Azure](https://azure.microsoft.com/en-gb/blog/introducing-the-microsoft-azure-wellarchitected-framework/) Well-Architected Frameworks and the [NHS Digital quality review](review.md).

As discused in [Benefits](#benefits), in high level terms the opportunities for reducing waste or improving quality tend to be in two areas:

### 1. Process or practice

The [Lean principles](principles.md) give some useful areas to consider.

Examples include:
* The way stories are analysed or elaborated.
* The way code is written or reviewed.
* The tools and techniques for testing.
* Communication and collaboration mechanisms within and between teams.
* Team structures.

### 2. Technical debt

Examples include:
* Code which needs to be refactored.
* Technologies which should be replaced.
* Areas with insufficient, inefficient or ineffective testing.

## Prioritising

To do

## Acting

To do

## Measuring

When seeking to [identify](#identifying-improvement-opportunities) and [prioritise](#prioritising) improvements, it can be helpful to have agreed metrics as a guide. These will be specific to each team, but some good defaults to start with are:
* Deployment frequency
* Lead time for changes
* Incident rate
* Mean time to recover
* Team happiness
* Proportion of time being spent on:
  * Features.
  * Bug fixing.
  * Operability.
  * Tech debt.
  * Other improvement work.
