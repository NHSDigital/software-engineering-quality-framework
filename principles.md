# Engineering principles

- [Engineering principles](#engineering-principles)
  - [Details](#details)
    - [1. Eliminate waste](#1-eliminate-waste)
    - [2. Build quality in](#2-build-quality-in)
    - [3. Create knowledge](#3-create-knowledge)
    - [4. Defer commitment](#4-defer-commitment)
    - [5. Deliver as fast as possible](#5-deliver-as-fast-as-possible)
    - [6. Respect for people](#6-respect-for-people)
    - [7. Optimise the whole](#7-optimise-the-whole)

## Details

Our principles guide the way we work and interact with each other. They are based on the seven Lean principles as expressed in Lean Software Development: An Agile Toolkit by Mary Poppendieck and Tom Poppendieck.

### 1. Eliminate waste

Waste is anything that interferes with giving customers what they really value at the time and place where it will provide the most value. Here are some examples, listed against the seven types of waste identified by Lean:

- **Inventory &mdash; partially done work**, e.g. plans and designs, code shelved halfway. Limit work in progress (WIP) and use a pull-based approach.

- **Inventory &mdash; [unnecessary resources](practices/cloud-services.md)** [[ARCHITECTURE-SUSTAINABILITY]](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/deliver-sustainable-services), e.g. server over-provisioning, complicated tools where simple ones would do. Adopt a "just enough, not just in case" mindset.

- **Overproduction &mdash; planning or designing in excessive detail.** Requirements change, therefore use a "just enough, just in time" approach to both. Detail should be added as you move to the right in the [cone of uncertainty](http://www.agilenutshell.com/cone_of_uncertainty).

- **Overproduction &mdash; overengineering**, i.e. building unnecessary features, unwarranted levels of code perfection or quantities of tests, or premature optimisation. Start simple and prefer explicit logic to implicit. Be pragmatic and balance effort now with saved effort or risk in the future. Remember [KISS](http://principles-wiki.net/principles:keep_it_simple_stupid) and [YAGNI](https://www.martinfowler.com/bliki/Yagni.html) and see the caveats in [structured code](practices/structured-code.md).

- **Overproduction &mdash; reinventing the wheel.** Solving the same problem repeatedly in an organisation, or building when you could reuse or buy [[ARCHITECTURE-REUSE]](https://digital.nhs.uk/about-nhs-digital/our-work/nhs-digital-architecture/principles/reuse-before-buy-build). Make sure there are effective ways to share knowledge between teams to avoid this.

- **Extra Processing &mdash; due to delayed integration** making merging / reconciliation and testing harder. Use [continuous integration](practices/continuous-integration.md) with frequent merges. When combined with Test-Driven Development, this will allow bugs to be detected early when they are cheap to fix.

- **Hand-offs** (“Transportation” and “Waiting” in Lean terminology) &mdash; excessive passing of work between individuals or teams. Develop multi-skilled individuals and cross-functional product teams. Apply the [Shift Left](https://www.testim.io/blog/shift-left-testing-guide/) principle to testing and other areas of your SDLC.

- **Context switching &mdash; due to too much work in progress (WIP) or poorly segregated work.** Limit WIP explicitly. Focus on optimising lead time. For project vs. support work, implement time-slicing or rota systems to allow focus and prevent reactiveness.

- **Defects** due to not understanding requirements properly or bugs leaking through. Use approaches described in the next section.

### 2. Build quality in

The following practices support the principle of building quality in.

**Collaborative analysis and elaboration** with the right people involved to examine a change from all angles to ensure requirements are fully understood at the point the work will be done.

**[Deploy safely.](patterns/deployment.md)** Use automation and repeatable processes to ensure that products can be deployed safely.

**[Deliver incrementally.](patterns/little-and-often.md)** Establish build-measure-learn loops to keep the system simple and to ensure it meets evolving user needs.

**Pair programming**. Avoid quality issues by combining the skills and experience of two developers instead of one. Take advantage of navigator and driver roles. Also consider cross-discipline (e.g. dev-test) pairing.

**[Test automation.](practices/testing.md)** and **[build for testability](practices/structured-code.md)** Use test-driven development: Write the tests hand in hand with the code it is testing to ensure code is easily testable and does just enough to meet the requirements.

**[Protect code quality](patterns/everything-as-code.md)** to keep code easy to maintain.

**Write less code.** Treat code as a liability rather than an asset: the more code, the more there is to go wrong. Incremental delivery and test driven development both help keep the codebase small and simple.

**[Continuous integration.](practices/continuous-integration.md)** Build automated code quality checks and tests: security, accessibility etc. Use frequent code merges.

**Minimise hand-offs** to reduce knowledge gaps.

**[Automate](patterns/automate-everything.md)** any tedious, manual process or any process prone to human error.

**Refactor often** &mdash; expect to change existing code.

**Maintain actively** &mdash; prioritise fixing bugs and tech debt.

**Keep it simple.** Explicit is better than implicit. Simple is better than complex. Complex is better than complicated.  Special cases aren't special enough to break the rules. Although practicality beats purity. ([Zen of Python](https://www.python.org/dev/peps/pep-0020/).)

**[Prefer serverless](practices/cloud-services.md). [SERVICE-TOOLS](https://service-manual.nhs.uk/service-standard/11-choose-the-right-tools-and-technology) Where not serverless use ephemeral and immutable infrastructure.** Make it simple to guarantee predictable and reliable behaviour.

**[Bake in security.](practices/security.md)** Understand it as a team. Consider it through every stage of delivery. Verify it automatically and continuously. Model risks. Use defence in depth. Segregate security domains (e.g. test/prod, public/PII). Minimise human contact with sensitive data.

**Stay up to date.** Automate patching/upgrades, dependency/image scanning and updating.

**Bake in [observability](practices/observability.md) and [reliability](practices/service-reliability.md).** [SERVICE-RELIABILITY](https://service-manual.nhs.uk/service-standard/14-operate-a-reliable-service) Understand requirements as a team, treated as unspoken user needs. Consider it through every stage of delivery. Verify it automatically and continuously. Practice incident management resolution using techniques like [game days](https://wa.aws.amazon.com/wat.concept.gameday.en.html).

### 3. Create knowledge

**Generate knowledge.** Make time for activities which help us learn by doing, e.g. spikes, proof of concepts. Validation of technical design comes as the code is being written &mdash; expect the design to evolve. Encourage learning and experimentation.

**Gather knowledge.** Release a minimum feature set early for evaluation and feedback and continue to iterate and get feedback. Use continuous integration and live service monitoring and analytics to gain insight on code and system health.

**Share knowledge.** e.g. pair programming, code reviews, show and tell. Consider whether encoding knowledge in tools would assist other members of your team, for example building a VSCode extension to provide contextual information and tips for using a bespoke test harness.

**Record knowledge.** e.g. tests, self-documenting code, self-documenting system (e.g. [OpenAPI](https://swagger.io/resources/open-api/)), documentation &mdash; in that order.

**Record decisions.** Use the [Any Decision Record template](any-decision-record-template.md) to document point-in-time decisions providing information like context, assumption, drivers, options and rationale to articulate the decision for the stakeholders and your future self. Always, consider and compare options as a decision made without that is not a decision.

**Consider comments and Readme text** Comments in open source repos are not official communications and don't go through the normal approval process for public communication. They can however still be interpreted as NHSE communication, even if not intended as such, particularly for public repos. Especially when coding in the open, but also when developing in private repositories, consider the contents of Readme files and comments within the code. Ensure that comments add value to the code you are developing. Please avoid anything that could be considered a statement on approach/policy.  Consider the broader impact of any text in these areas to ensure that the project and the organisation are reflected correctly. Note that we produce and maintain services that are important to the public, therefore it is essential to be careful and accurate when referring to these services. If in doubt please ask. Also note there is high sensitivity around protecting privacy so please be careful your comments reflect the importance and sensitivity around protecting personal data.

### 4. Defer commitment

**Make decisions small** by breaking a big problem down.

**Make decisions reversible** whenever possible. e.g. prefer pay as you go to bulk buying, prefer cloud to physical infrastructure.

**Decide at the last responsible moment** for irreversible decisions.

**Just enough, just in time** &mdash; applied to all stages: research, analysis, product design, planning, technical design.

**Recognise architecturally significant decisions** that affect the structure, non-functional characteristics, dependencies, interfaces or construction techniques. A good architecture decision is one that helps guide development teams in making the right technical choices.

### 5. Deliver as fast as possible

We need to figure out how to deliver software as fast as possible.  This reduces the cycle time for change, allows the business to reach the point of increased learning sooner and provides more immediate gratification and feedback for the customer.  This also allows us to defer commitment as much as possible.

**Eliminate waste** (as above).

**[Deliver little and often.](patterns/little-and-often.md)** Prefer lots of small changes (with automation doing the heavy lifting) to fewer large changes

**Start simple and iterate.** Structure projects as distinct discovery, inception and build stages to allow commitment to be incrementally increased. Start with an MVP /  [steel thread](https://www.agiledevelopment.org/agile-talk/111-defining-acceptance-criteria-using-the-steel-thread-concept) / [walking skeleton](https://www.henricodolfing.com/2018/04/start-your-project-with-walking-skeleton.html).

**Sustainable pace.** Work at a pace which is sustainable long term.

**Choose the right tools for each job.** [SERVICE-TOOLS](https://service-manual.nhs.uk/service-standard/11-choose-the-right-tools-and-technology) Balance autonomy and conformity: unnecessary proliferation of a wide variety of tools impacts overall effectiveness, but limiting too much promotes "least worst" choices. Note that "each job" does not have to mean a single toolset for a service: consider a polyglot approach for component-based services.

### 6. Respect for people

**Communicate** e.g. stand-ups, retrospectives, show and tell / demo.

**Give and receive feedback.** Give with honesty and respect; receive gratefully.

**Encourage healthy debate.** e.g. collaborative analysis and elaboration with the right people involved to examine a change from all angles, functionality/quality priority competition, collaborative design.

**Foster a growth mindset.** Invest in learning and individual development.

**Default to self-organising and peer to peer** whenever possible. Minimise hierarchy and bureaucracy.

**Safe to fail.** Individual mistakes should not have serious consequences. Build in guards and automate whenever practical.

**No blame.** When things go wrong, treat it as a learning opportunity for the team and organisation. Use blameless post mortems and Five Whys.

**[Use inclusive language.](inclusive-language.md)** Avoid terms which cause hurt and offence, including if they have historically been considered industry-standard terms.

### 7. Optimise the whole

**Visualise the work.** Map the value stream with a Kanban board, identify bottlenecks.

**Optimise the bottleneck.** Use the theory of constraints.

**Use feedback loops** to avoid negative global effects from local optimisations.

**Balance autonomy and conformity.** Teams use the right tool for the job, within reason: unchecked proliferation of a wide variety of tools impacts the overall effectiveness of the organisation.
