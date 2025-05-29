# Feature Toggling

- [Feature Toggling](#feature-toggling)
  - [Context](#context)
  - [The intent](#the-intent)
  - [Key takeaway](#key-takeaway)
  - [Background](#background)
  - [What is feature toggling?](#what-is-feature-toggling)
  - [Why use feature toggling?](#why-use-feature-toggling)
  - [Types of toggles](#types-of-toggles)
  - [Managing toggles](#managing-toggles)
  - [Caveats](#caveats)
  - [Toggling strategy](#toggling-strategy)
  - [Toggle lifecycle](#toggle-lifecycle)
    - [Best practice lifecycle](#best-practice-lifecycle)
  - [Testing toggled features](#testing-toggled-features)
  - [Designing for failure](#designing-for-failure)
  - [Further reading](#further-reading)

## Context

- These notes are part of our broader [engineering principles](../principles.md).
- Feature toggling contributes to safer delivery, reduced deployment risk, and enhanced responsiveness to change.

## The intent

We use feature toggling as a key enabling practice to support our move towards daily code integration and deployment, including multiple deployments per day. Feature toggling allows us to separate deployment from release, so that incomplete features can be merged and deployed without impacting end users. It enables incremental development by allowing small, frequent commits to `main`, and supports risk-managed rollouts by enabling functionality selectively. Importantly, it also provides a mechanism for rapid rollback without reverting code. This approach is critical to mitigating the risks associated with frequent deployments, and is foundational to achieving a safe and sustainable continuous delivery model.

## Key takeaway

- Feature toggling enables functionality to be turned on or off without deploying new code.
- It separates deployment from release, allowing code to be safely deployed without activating a feature.
- Toggles should be explicitly managed with clear naming, documented intent, and timely removal.
- Toggle abuse (too many, long-lived, or undocumented flags) leads to tech debt and complex logic.

## Background

Feature toggling, also known as feature flags, is a technique for modifying system behaviour without changing code by checking a condition (usually externalised) at runtime. It is often used to control feature rollouts, manage risk, and test changes in production.

This is particularly powerful in continuous delivery environments where small, frequent changes are the norm. It supports practices like canary releases, A/B testing, and operational kill switches.

For a detailed and widely referenced introduction to this practice, see Martin Fowler's article on [Feature Toggles](https://martinfowler.com/articles/feature-toggles.html).

While some areas are looking to adopt a more enterprise-grade offering with Flagsmith, it's important to recognise that more minimal feature toggle approaches may be appropriate for smaller or simpler systems. The [Thoughtworks Technology Radar](https://www.thoughtworks.com/radar) notes that many teams over-engineer feature flagging by immediately adopting complex platforms, when a simpler approach (e.g., environment variables or static config) would suffice. However, irrespective of how the toggle is implemented, the **governance, traceability, and lifecycle management processes should be consistent**.

## What is feature toggling?

Feature toggling works by introducing conditional logic into the application code. This logic evaluates a configuration value or remote toggle to determine whether to execute a new or existing code path.

Toggles can be defined statically (e.g., environment variable or config file) or dynamically (e.g., via an external feature flag service). Dynamic toggles can be changed without restarting or redeploying the application.

## Why use feature toggling?

- **Decouple deployment from release**: Code can be deployed behind a toggle and activated later.
- **Enable safe rollouts**: Enable features for specific users or teams to validate functionality before full rollout.
- **Support operational control**: Temporarily disable a feature causing issues without rollback.
- **Enable experimentation**: Run A/B tests to determine user impact.
- **Configure environment-specific behaviour**: Activate features in dev or test environments only.

## Types of toggles

According to Martin Fowler, toggles typically fall into the following categories:

- **Release toggles**: Allow incomplete features to be merged and deployed.
- **Experiment toggles**: Support A/B or multivariate testing.
- **Ops toggles**: Provide operational control for performance or reliability.
- **Permission toggles**: Enable features based on user roles or attributes.

## Managing toggles

Poorly managed toggles can lead to complexity, bugs, and technical debt. Best practices include:

- Give toggles meaningful, consistent names.
- Store toggle state in a centralised and observable system.
- Document the purpose and expected lifetime of each toggle.
- Remove stale toggles once their purpose is fulfilled. Ideally integrate this into your CI pipeline to report on stale flags.
- Avoid nesting toggles or creating toggle spaghetti.
- Ensure toggles are discoverable, testable, and auditable.

## Caveats

Whilst there are obvious benefits to Feature Toggling, there are some caveats worth bearing in mind when implementing them

- **Performance Overhead**: Feature toggles can introduce performance overhead if they are checked frequently, especially within loops and every evaluation goes back to the server.
- **Toggle Bloat & Technical Debt**: Toggles are intended for short term use, failure to adhere to this principle can lead to conditional sprawl of if statements, harder code to read and maintain and increased risk of toggle conflicts or becoming orphaned
- **Test Complexity**: More toggles increase your permutations around a single test path. A single toggle doubles the test scenarios and needs careful factoring in to the test approach.
- **Increased Logging/Observability Needs**; Now need to know the state of the toggles at the point of the logs, otherwise inspecting the logs becomes incredibly difficult.

## Toggling strategy

Choose a feature flagging approach appropriate for the scale and complexity of your system:

- **Simple applications**: Environment variables or configuration files.
- **Moderate scale and beyond**: Look to make use of e.g. [Flagsmith](https://www.flagsmith.com/), which supports targeting, analytics, and team workflows.

Feature toggles should be queryable from all components that need access to their values. Depending on your architecture, this may require synchronisation, caching, or SDK integration.

## Toggle lifecycle

Toggles are intended to be short-lived unless explicitly designed to be permanent (e.g. permission toggles).

### Best practice lifecycle

1. **Introduce** the toggle with a clear purpose and target outcome.
2. **Implement** the feature behind the toggle.
3. **Test** the feature in both on/off states.
4. **Roll out** gradually (e.g., canary users, targeted groups).
5. **Monitor** the impact of the feature.
6. **Remove** the toggle once the feature is stable and fully deployed.

Document toggles in your architecture or delivery tooling to ensure visibility and traceability.

## Testing toggled features

Features behind toggles should be tested in both their enabled and disabled states. This ensures correctness regardless of the toggle value.

- Write tests that explicitly set the toggle on and off.
- Use test frameworks that allow injecting or mocking toggle values.
- Consider test coverage for the toggle transitions (e.g., changing at runtime).
- Ensure integration and end-to-end tests include scenarios where toggles are disabled.

This is particularly important for toggles that persist for more than one release cycle.

## Designing for failure

Feature toggles should never become a point of failure. Design your system so that it behaves predictably even if the toggle service is unavailable or fails to return a value.

Best practices:

- Default values: Every toggle should have a known and safe default (either on or off) hardcoded in the consuming service.
- Fail-safe logic: Ensure that remote flag checks have timeouts and fallback paths.
- Graceful degradation: Systems should still function, possibly with reduced capability, if a toggle cannot be resolved.
- Resilient integration: Ensure that SDKs or services used for toggling are resilient and do not block application startup or core functionality.

## Further reading

- [Feature Toggles by Martin Fowler](https://martinfowler.com/articles/feature-toggles.html)
- [Unleash Strategies and Best Practices](https://docs.getunleash.io/topics/feature-flags/feature-flag-best-practices)
- [Flagsmith Docs](https://docs.flagsmith.com/)
- [Feature Flag Best Practices](https://launchdarkly.com/blog/best-practices-for-coding-with-feature-flags/)
- [Thoughtworks Tech Radar](https://www.thoughtworks.com/radar/techniques/minimum-feature-toggle-solution)
- [Defensive coding](https://docs.flagsmith.com/guides-and-examples/defensive-coding)
