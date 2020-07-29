# Introduction

Our principles guide the way we work and interact with each other. They are based on the seven Lean principles as expressed in Lean Software Development: An Agile Toolkit by Mary Poppendieck and Tom Poppendieck.

# 1. Eliminate waste

Waste is anything that interferes with giving customers what they really value at the time and place where it will provide the most value. Here are some examples, listed against the seven types of waste identified by Lean.

**Inventory &mdash; partially done work**, e.g. plans and designs, code. Limit work in progress (WIP) and use a pull-based approach.

**[Inventory &mdash; unnecessary resources.](principles/unnecessary-resources.md)**, e.g. server over-provisioning, complicated tools where simple ones would do. Adopt a "just enough, not just in case" mindset.

**Overproduction &mdash; building unnecessary features.** Start simple and basic, get feedback and iterate.

**Overproduction &mdash; planning or designing in excessive detail.** Use a "just enough, just in time" approach to both.

**Overproduction &mdash; overengineering**, i.e. building unwarranted levels of code perfection or quantities of tests. Be pragmatic and balance effort now with saved effort or risk in the future. Remember [KISS](http://principles-wiki.net/principles:keep_it_simple_stupid) and [YAGNI](https://www.martinfowler.com/bliki/Yagni.html).

**Overproduction &mdash; reinventing the wheel.** Solving the same problem repeatedly in an organisation. Make sure there are effective ways to share knowledge between teams to avoid this.

**[Overproduction &mdash; building when you could instead reuse or buy.](principles/cloud-services.md)** Remember to consider all these alternatives.

**Overproduction &mdash; premature optimisation for reusability.** Before making something reusable, first make it usable. Prefer explicit logic to implicit. Excessively generic systems create accidental complexity. [KISS](http://principles-wiki.net/principles:keep_it_simple_stupid) and [YAGNI](https://www.martinfowler.com/bliki/Yagni.html) again.

**Overproduction &mdash; premature optimisation**, e.g. for performance or scale. Design with both in mind, but not excessively so. Defer optimisation until testing shows it is necessary. Start simple, test, iterate.

**Extra Processing &mdash; due to changing requirements.** Use just enough, just in time approach to understanding requirements and deliver small iterations in a build-measure-learn loop.

**Extra Processing &mdash; due to delayed integration** making merging / reconciliation harder. Use [continuous integration](principles/continuous-integration.md) with frequent merges.

**Extra Processing &mdash; due to late testing.** When testing is done after implementation, especially if long after, bugs become more time consuming to detect and fix. Use test driven development and [continuous integration](principles/continuous-integration.md).

**Hand-offs** (“Transportation” and “Waiting” in Lean terminology) &mdash; excessive passing of work between individuals or teams. Develop multi-skilled individuals and cross-functional product teams.

**Context switching &mdash; due to too much work in progress (WIP).** Limit WIP explicitly. Focus on optimising lead time.

**Context switching &mdash; due to poorly segregated work** (e.g. project vs support). Identify different classes of work and create separation with time-slice or rota systems to avoid reactive work from destroying productivity.

**Defects** due to not understanding requirements properly or bugs leaking through. Use approaches described in the next section.

# 2. Build quality in

The following practices support the principle of building quality in.

**Three amigos analysis and elaboration** to ensure requirements are fully understood at the point the work will be done.

**Deliver incrementally.** Establish build-measure-learn loops to keep the system simple and to ensure it meets evolving user needs.

**Pair programming**. Avoid quality issues by combining the skills and experience of two developers instead of one. Take advantage of navigator and driver roles. Also consider cross-discipline (e.g. dev-test) pairing.

**[Test automation.](principles/test-automation.md)** Use test-driven development: Write the tests hand in hand with the code it is testing to ensure code is easily testable and does just enough to meet the requirements.

**[Protect code quality](principles/code.md)** to keep code easy to maintain.

**Write less code.** Treat code as a liability rather than an asset: the more code, the more there is to go wrong. Incremental delivery and test driven development both help keep the codebase small and simple.

**[Continuous integration.](principles/continuous-integration.md)** Build automated code quality checks and tests &mdash; security, accessibility etc. Use frequent code merges.

**Minimise hand-offs** to reduce knowledge gaps.

**[Automate](principles/automation.md)** any tedious, manual process or any process prone to human error.

**Refactor often** &mdash; expect to change existing code.

**Maintain actively** &mdash; prioritise fixing bugs and tech debt.

**Keep it simple.** Explicit is better than implicit. Simple is better than complex. Complex is better than complicated. Complex is better than complicated.  Special cases aren't special enough to break the rules. Although practicality beats purity. ([Zen of Python](https://www.python.org/dev/peps/pep-0020/).)

**Prefer serverless; where not serverless use ephemeral and immutable infrastructure.** Make it simple to guarantee predictable and reliable behaviour.

**[Bake in security.](principles/security.md)** Understand it as a team. Consider it through every stage of delivery. Verify it automatically and continuously. Model risks. Use defence in depth. Segregate security domains (e.g. test/prod, public/PII). Minimise human contact with sensitive data.

**Stay up to date.** Automate patching/upgrades, dependency/image scanning and updating.

**[Bake in reliability.](principles/reliability.md)** Understand requirements as a team, treated as unspoken user needs. Consider it through every stage of delivery. Verify it automatically and continuously. Practice incident management resolution using techniques like [game days](https://wa.aws.amazon.com/wat.concept.gameday.en.html).

# 3. Create knowledge

**Generate knowledge.** Make time for activities which help us learn by doing, e.g. spikes, proof of concepts. Validation of technical design comes as the code is being written &mdash; expect the design to evolve. Encourage learning and experimentation.

**Gather knowledge.** Release a minimum feature set early for evaluation and feedback and continue to iterate and get feedback. Use continuous integration and live service monitoring and analytics to gain insight on code and system health.

**Share knowledge.** e.g. pair programming, code reviews, show and tell.

**Record knowledge.** e.g. tests, self-documenting code, self-documenting system (e.g. [OpenAPI](https://swagger.io/resources/open-api/)), documentation &mdash; in that order.

# 4. Defer commitment

**Make decisions small** by breaking a big problem down.

**Make decisions reversible** whenever possible. e.g. prefer pay as you go to bulk buying, prefer cloud to physical infrastructure.

**Decide at the last responsible moment** for irreversible decisions.

**Just enough, just in time** &mdash; applied to all stages: research, analysis, product design, planning, technical design.

# 5. Deliver fast

We need to figure out how to deliver software so fast that our customers don’t have time to change their minds.

**Eliminate waste** (as above).

**Deliver little and often.** Prefer lots of small changes (with automation doing the heavy lifting) to fewer large changes

**Start simple and iterate.** Structure projects as dinstinct discovery, inception and build stages to allow commitment to be incrementally increased. Start with an MVP /  [steel thread](https://www.agiledevelopment.org/agile-talk/111-defining-acceptance-criteria-using-the-steel-thread-concept) / [walking skeleton](https://www.henricodolfing.com/2018/04/start-your-project-with-walking-skeleton.html).

**Sustainable pace.** Work at a pace which is sustainable long term.

**Choose the right tools for each job.** Balance autonomy and conformity: unnecessary proliferation of a wide variety of tools impacts overall effectiveness, but limiting too much promotes "least worst" choices. Note that "each job" does not have to mean a single toolset for a service: consider a polyglot approach for component-based services.

# 6. Respect for people

**Communicate.** e.g. stand-ups, retrospectives, show and tell / demo.

**Give and receive feedback.** Give with honesty and respect; receive gratefully.

**Encourage healthy conflict.** e.g. three amigos analysis and elaboration, functionality/quality priority competition, collaborative design.

**Foster a growth mindset.** Invest in learning and individual development.

**Default to self-organising and peer to peer** whenever possible. Minimise hierarchy and bureaucracy.

**Safe to fail.** Individual mistakes should not have serious consequences. Build in guards and automate whenever practical.

**No blame.** When things go wrong, treat it as a learning opportunity for the team and organisation. Use blameless post mortems and Five Whys.

# 7. Optimise the whole

**Visualise the work.** Map the value stream with a Kanban board, identify bottlenecks.

**Optimise the bottleneck.** Use the theory of constraints.

**Use feedback loops** to avoid negative global effects from local optimisations.

**Balance autonomy and conformity.** Teams use the right tool for the job, within reason &mdash; unchecked proliferation of a wide variety of tools impacts overall effectiveness of the organisation.
