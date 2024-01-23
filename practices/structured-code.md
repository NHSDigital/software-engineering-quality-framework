# Structured code

- [Structured code](#structured-code)
  - [Context](#context)
  - [Details](#details)

## Context

- These notes are part of a broader set of [principles](../principles.md)
- These practices should be read in conjunction with [architect for flow](../patterns/architect-for-flow.md)

## Details

- Good code structure is essential for maintainability.
- Use a framework:
  - All but the most trivial applications should be built using a framework, for example [React](https://reactjs.org) or [Vue.js](https://vuejs.org) for web UIs, [Express](https://expressjs.com), [ASP.NET](https://dotnet.microsoft.com/apps/aspnet) or [Flask](https://flask.palletsprojects.com/en/1.1.x/) for server-side web development, and [Spark](https://spark.apache.org) or [Flink](https://flink.apache.org) for data processing.
  - Frameworks help you produce results more quickly by reducing the amount of [boilerplate code](https://en.wikipedia.org/wiki/Boilerplate_code) you need to write.
  - They also make your code more maintainable because they encourage a standard structure which will be familiar to anyone who knows that framework. For this reason it is important to follow the conventions of the chosen framework rather than fighting them.
  - However, remember to keep it simple: don't use framework features when built-in language or standard library features will suffice as it reduces portability  &mdash; the ability to reuse the code in a different context. And don't use framework features for the sake of it: keep your code and the use of frameworks as simple as possible.
- Use libraries:
  - Avoid writing code which is not specific to your business domain: there will usually be libraries which will already do it better. Common examples are string manipulation, forming http requests and cryptography ([of course](https://security.stackexchange.com/questions/18197/why-shouldnt-we-roll-our-own)).
  - However, be wary of [over-reliance on micro packages](https://arxiv.org/pdf/1709.04638.pdf) for code which is trivial to implement yourself or (the other extreme) importing all of a large general-purpose library if you only need to use a small part of it &mdash; a particular problem in front end development.
- Structure for separation of concerns:
  - The aim is for the code changes required to add or change functionality to be localised: a small amount of code which can be easily changed with a low risk of affecting unrelated functionality.
  - Code with good separation of concerns is [modular](http://singlepageappbook.com/maintainability1.html) and [layered](https://www.oreilly.com/library/view/software-architecture-patterns/9781491971437/ch01.html).
  - Frameworks typically encourage layering, but don't help much with modularity. It is up to you to identify where code should be split into separate 'modules', such as functions or classes.
  - One good application of this kind of separation is to reduce the coupling between specific technologies and business logic. For example, the business logic should be separated out to insulate it from knowledge of the specific database being used and the invocation mechanism (e.g. [Lambda handler function](https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html) or [Flask http request handler function](https://flask.palletsprojects.com/en/1.1.x/quickstart/#routing)).
  - Judicious use of [design patterns](https://en.wikipedia.org/wiki/Software_design_pattern#Classification_and_list) can improve code modularity.
- Keep it simple:
  - Separation of concerns is essential to well-structured code, but be careful not to overdo it, introducing excessive abstraction which overcomplicates the code. Sometimes the overhead of introducing more modularity or layering can actually make code harder to maintain.
  - Large portions of near-duplicate code reduces maintainability: fixes in one area need to be manually applied across all the near-duplicates which creates effort &mdash; and where this is not done consistently unintentional variation in behaviour results.
  - Modularising code is a good way to reduce duplication. However, duplication is not always the greatest evil and sometimes a little duplication is better than the abstraction which would be needed to remove the duplication.
