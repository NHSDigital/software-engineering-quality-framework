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

We use feature toggling as a **key enabling practice to support our move towards daily code integration and deployment, including multiple deployments per day** - this is the main motivation behind introducing this practice. Feature toggling allows us to separate deployment from release, so that incomplete features can be merged and deployed without impacting end users. It enables incremental development by allowing small, frequent commits to `main`, and supports risk-managed rollouts by enabling functionality selectively. Importantly, it also provides a mechanism for rapid rollback without reverting code. This approach is critical to mitigating the risks associated with frequent deployments, and is foundational to achieving a safe and sustainable continuous delivery model.

## Key takeaway

- Feature toggling enables functionality to be turned on or off without deploying new code.
- It separates deployment from release, allowing code to be safely deployed without activating a feature.
- Toggles should be explicitly managed with clear naming, documented intent, and timely removal.
- Toggle abuse (too many, long-lived, or undocumented flags) leads to tech debt and complex logic.

## Background

Feature toggling, also known as feature flags, is a technique for modifying system behaviour without changing code by checking a condition (usually externalised) at runtime. It is often used to control feature rollouts, manage risk, and test changes in production.

This is particularly powerful in continuous delivery environments where small, frequent changes are the norm. It supports practices like canary releases, A/B testing, and operational kill switches.

For a detailed and widely referenced introduction to this practice, see Martin Fowler's article on [Feature Toggles](https://martinfowler.com/articles/feature-toggles.html).

While some areas are looking to adopt a more enterprise-grade offering with a dedicated feature toggling tool, it's important to recognise that more minimal feature toggle approaches may be appropriate for smaller or simpler systems. The [Thoughtworks Technology Radar](https://www.thoughtworks.com/radar) notes that many teams over-engineer feature flagging by immediately adopting complex platforms, when a simpler approach (e.g., environment variables or static config) would suffice. However, irrespective of how the toggle is implemented, the **governance, traceability, and lifecycle management processes should be consistent**.

## What is feature toggling?

Feature toggling works by introducing conditional logic into the application code. This logic evaluates a configuration value or remote toggle to determine whether to execute a new or existing code path.

Toggles can be defined statically (e.g., environment variable or config file) or dynamically (e.g., via an external feature flag service). Dynamic toggles can be changed without restarting or redeploying the application.

## Why use feature toggling?

- **Decouple deployment from release**: Deploy code behind a toggle and activate it later.
- **Enable safe rollouts**: Enable features for specific users or teams to validate functionality before full rollout.
- **Support operational control**: Temporarily disable a feature which is causing issues, without needing to rollback.
- **Enable experimentation**: Run A/B tests to determine user impact.
- **Configure environment-specific behaviour**: Activate features in dev or test environments only.

## Types of toggles

According to Martin Fowler, toggles typically fall into the following categories:

- **Release toggles**: Allow incomplete features to be merged and deployed.

> [!NOTE]
> For teams practising daily integration and deployment, feature flagging is a foundational capability. It enables separation of deployment from release, allowing incomplete features to be merged, deployed, and safely hidden from users until ready. Where a product’s needs are focused on basic **canary releasing**, and the aspiration for daily deployment to production is yet to be realised, teams may choose to start with the native capabilities of their cloud provider (e.g., Azure deployment slots, AWS Lambda aliases, or traffic-routing rules). These offer infrastructure-level rollout control with minimal additional complexity or reliance on third-party tooling.

- **Experiment toggles**: Support A/B or multivariate testing.

> [!NOTE]
> True **A/B testing**, involving consistent user assignment, behavioural metrics, and statistical comparison, typically requires additional tooling to manage variant bucketing, exposure logging, and result analysis. In such cases, dedicated services are more appropriate, as the solutions can be subtle and mathematically complex (consider issues such as ["Optional Stopping" or "Peeking Bias"](https://www.evanmiller.org/how-not-to-run-an-ab-test.html)). We do not want to have to re-invent them. Teams are encouraged to start simple, and evolve their approach as feature granularity, targeting precision, analytical needs, and user expectations increase.

- **Ops toggles**: Provide operational control for performance or reliability.
- **Permission toggles**: Enable features based on user roles or attributes.

> [!WARNING]
> While permission toggles can target users by role or attribute during a rollout or experiment, they are not a replacement for robust, permanent role-based access control (RBAC). Use RBAC as a separate, first-class mechanism for managing user permissions.

## Managing toggles

Poorly managed toggles can lead to complexity, bugs, and technical debt. Best practices include:

- Give toggles meaningful, consistent names.
- Document the purpose and expected lifetime of each toggle.
- Store toggle state in an observable system.
- Guard the feature behind a single toggle check, and pass the resulting behaviour or strategy through your code to minimise duplication and simplify removal.
- Ensure toggles are discoverable, testable, and auditable.
- Avoid nesting toggles or creating toggle spaghetti.
- Remove stale toggles once their purpose is fulfilled. Ideally integrate this into your CI pipeline to report on stale flags.

Changing a toggle’s state can significantly impact system behaviour, especially in live environments. These changes should therefore be treated with the same rigour as code changes. Recommended practices include:

- All toggle changes — whether in code or dynamic configuration stores — should be peer reviewed and documented. For code-based toggles, this naturally happens via pull requests.
- Use a feature toggle system or configuration store that logs all changes, including who made them, when, and the before/after values.
- Where possible, verify the impact of a toggle change in a non-production environment before enabling it in live.
- When enabling or disabling a toggle, communicate with relevant stakeholders, particularly for user-facing or operational changes.
- Where practical, manage toggle values through infrastructure-as-code or parameterised pipelines to allow version-controlled, reviewed, and auditable changes.

## Caveats

Whilst there are obvious benefits to Feature Toggling, there are some caveats worth bearing in mind when implementing them

- **Performance Overhead**: Feature toggles can introduce performance overhead if they are checked frequently, especially within loops and every evaluation goes back to the server.
- **Toggle Bloat & Technical Debt**: Toggles are intended for short term use, failure to adhere to this principle can lead to conditional sprawl of if statements, harder code to read and maintain and increased risk of toggle conflicts or becoming orphaned
- **Test Complexity**: More toggles increase your permutations around a single test path. A single toggle doubles the test scenarios and needs careful factoring in to the test approach.
- **Increased Logging/Observability Needs**; Now need to know the state of the toggles at the point of the logs, otherwise inspecting the logs becomes incredibly difficult.

## Toggling strategy

Choose a feature flagging approach appropriate for the scale and complexity of your system:

- **Simple applications**: Environment variables or configuration files.
- **Moderate scale and beyond**: Look to make use of a dedicated feature toggling tool, which supports targeting, analytics, and team workflows.

Feature toggles should be queryable from all components that need access to their values. Depending on your architecture, this may require synchronisation, caching, or SDK integration.

## Toggle lifecycle

Toggles are intended to be short-lived unless explicitly designed to be permanent (e.g. permission toggles).

### Best practice lifecycle

1. **Introduce** the toggle with a clear purpose and target outcome.
2. **Keep it tidy** create a PR for the toggle removal called cleanup/feature_flag_name
3. **Implement** the feature behind the toggle.
4. **Test** the feature in both on/off states.
5. **Roll out** gradually (e.g., canary users, targeted groups).
6. **Monitor** the impact of the feature.
7. **Remove** the toggle once the feature is stable and fully deployed.

Document toggles in your architecture or delivery tooling to ensure visibility and traceability.

## Testing toggled features

Features behind toggles should be tested in both their enabled and disabled states. This ensures correctness regardless of the toggle value.

- Prefer testing the behaviour behind the toggle (e.g. via Strategy implementations) directly, rather than toggling features within tests.
- Where the Strategy Pattern is used, write separate unit tests for each strategy to validate their behaviour in isolation.
- If toggling is required in tests, use frameworks that allow injecting or mocking toggle values cleanly.
- Ensure integration and end-to-end tests include scenarios with the toggle both enabled and disabled, especially if the toggle is expected to persist across multiple releases.
- Include toggle state in test names or descriptions to clarify test intent (e.g. `shouldReturnNull_whenFeatureDisabled()`).
- Track test coverage across both toggle states and regularly review it for long-lived or critical toggles.
- Ensure test coverage includes edge cases introduced by toggled logic, such as different user roles, environment-specific behaviour, or state transitions.
- Use contract tests where toggled behaviour affects external APIs or integrations to ensure they remain backward-compatible.
- Avoid asserting on the presence or structure of toggle code itself, focus on testing expected outcomes.

This is particularly important for toggles that persist for more than one release cycle.

## Designing for failure

If you are using a feature toggle service external to the application, feature toggles should never become a point of failure. Design your system so that it behaves predictably even if the toggle service is unavailable or fails to return a value.

Best practices:

- Default values: Every toggle should have a known and safe default (either on or off) hardcoded in the consuming service.
- Fail-safe logic: Ensure that remote flag checks have timeouts and fallback paths.
- Graceful degradation: Systems should still function, possibly with reduced capability, if a toggle cannot be resolved.
- Resilient integration: Ensure that SDKs or services used for toggling are resilient and do not block application startup or core functionality.

## Further reading

- [Feature Toggles (aka Feature Flags) by Martin Fowler](https://martinfowler.com/articles/feature-toggles.html)
- [Thoughtworks Tech Radar](https://www.thoughtworks.com/radar/techniques/simplest-possible-feature-toggle)
- [11 principles for building and scaling feature flag systems](https://docs.getunleash.io/topics/feature-flags/feature-flag-best-practices)
- [Best practices for coding with feature flags](https://launchdarkly.com/blog/best-practices-for-coding-with-feature-flags/)
- [Defensive coding](https://docs.flagsmith.com/guides-and-examples/defensive-coding)
- [An example tool for feature toggling](https://docs.flagsmith.com/)
- [How to use feature flags without technical debt](https://launchdarkly.com/blog/how-to-use-feature-flags-without-technical-debt/)
- [Scaling Feature Flags - A Roadmap for Safer Releases & Faster Development](https://143451822.fs1.hubspotusercontent-eu1.net/hubfs/143451822/eBooks/eBook:%20Scaling%20Feature%20Flags%20-%20A%20Roadmap%20for%20Safer%20Releases%20%26%20Faster%20Development.pdf)
- [Flip the Switch - Unlock Modern Software Development with Feature Flags](https://143451822.fs1.hubspotusercontent-eu1.net/hubfs/143451822/eBooks/Flip%20the%20Switch%20On%20Modern%20Software%20Development%20with%20Feature%20Flags%20-%20Flagsmith.pdf)
- [Modern Development Practices in Banking: A Playbook](https://143451822.fs1.hubspotusercontent-eu1.net/hubfs/143451822/eBooks/Modern%20Development%20Practices%20in%20Banking%20by%20Flagsmith.pdf)
