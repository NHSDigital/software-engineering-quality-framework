# Open Source

- [Open Source](#open-source)
  - [1. Context](#1-context)
  - [2. Open sourcing our own code](#2-open-sourcing-our-own-code)
  - [3. Open source dependencies](#3-open-source-dependencies)
    - [3.1 If your application is an API-only service](#31-if-your-application-is-an-api-only-service)
      - [3.1.1 If your application is coded in the open, or is to be open source](#311-if-your-application-is-coded-in-the-open-or-is-to-be-open-source)
        - [3.1.1.1 GPL-2.0](#3111-gpl-20)
        - [3.1.1.2 GPL-3.0](#3112-gpl-30)
        - [3.1.1.3 LGPL-3.0](#3113-lgpl-30)
        - [3.1.1.4 AGPL-3.0](#3114-agpl-30)
      - [3.1.2 If your application is closed source](#312-if-your-application-is-closed-source)
    - [3.2 If someone else runs your application](#32-if-someone-else-runs-your-application)
      - [3.2.1 GPL-2.0](#321-gpl-20)
      - [3.2.2 GPL-3.0](#322-gpl-30)
      - [3.2.3 LGPL-3.0](#323-lgpl-30)
    - [3.3 If your application runs in the user's browser](#33-if-your-application-runs-in-the-users-browser)
      - [3.3.1 If your application is coded in the open, or is to be open source](#331-if-your-application-is-coded-in-the-open-or-is-to-be-open-source)
        - [3.3.1.1 If your server and client components are distributed together](#3311-if-your-server-and-client-components-are-distributed-together)
        - [3.3.1.2 If your server and client components are distributed separately](#3312-if-your-server-and-client-components-are-distributed-separately)
      - [3.3.2 If your application is closed source](#332-if-your-application-is-closed-source)
  - [4. The LGPL: on Linking](#4-the-lgpl-on-linking)
    - [4.1 JavaScript on the web](#41-javascript-on-the-web)
    - [4.2 JavaScript on the server (node.js/bun)](#42-javascript-on-the-server-nodejsbun)
  - [5. What to do when a dependency changes licence](#5-what-to-do-when-a-dependency-changes-licence)
    - [5.1 Comply with the new licence](#51-comply-with-the-new-licence)
    - [5.2 Stay on the old version](#52-stay-on-the-old-version)
    - [5.3 Replace the dependency](#53-replace-the-dependency)

This section provides guidance for teams who either consume open source dependencies, or want to understand our responsibilities when we [code in the open](https://service-manual.nhs.uk/standards-and-technology/service-standard-points/12-make-new-source-code-open).

## 1. Context

- These notes are part of a broader set of [principles](../principles.md).
- They represent the Engineering community's interpretation of legal advice and licensing best practice for the context of software application delivery within and by NHS England, and should not be read as definitive outside that context.

## 2. Open sourcing our own code

[Item 12 in the Gov.UK Service Standard](https://www.gov.uk/service-manual/service-standard/point-12-make-new-source-code-open) reads as follows:

> Make all new source code open and reusable, and publish it under appropriate licences. Or if this is not possible, provide a convincing explanation of why this cannot be done for specific subsets of the source code.

We inherit this rule into NHS England's projects via the [NHS Service Manual](https://service-manual.nhs.uk/standards-and-technology/service-standard-points/12-make-new-source-code-open).

There is further guidance as to when publishing our source code would not be appropriate in the (draft) [Open Source Policy](https://github.com/nhsx/open-source-policy/blob/main/open-source-policy.md#3-when-code-should-be-open-or-closed).

The position of all three of these documents is that we should code in the open by default. If you are starting a new project then your first choice should be the [MIT Licence](https://choosealicense.com/licenses/mit/).  See [here](https://github.com/nhsx/open-source-policy/blob/main/open-source-policy.md#c-licences-and-regulatory-requirements) for the rationale, and for when alternatives may be appropriate.

There will be special cases where we need to deviate from the licences listed in the above guidance. For instance, if we were to build a reference implementation of an API standard, and we wanted to ensure that future developments of that reference implementation benefit the public commons, it may be suitable to choose the AGPL for that implementation. In such cases, where you believe that you may need to deviate from the [Open Source policy](https://github.com/nhsx/open-source-policy/blob/main/open-source-policy.md), you should consult the Engineering Technical Authority for advice.  While it is not (yet) a binding policy, it is a distillation of good practice and should be followed unless there is a good reason not to, as in this example.

## 3. Open source dependencies

All of our projects rely on open source dependencies to some degree.  We need to have confidence that we can comply, and are complying, with the terms of the licences which grant us permission to use those dependencies. Actions that we need to take will depend on how the application you are building will be deployed.

We must not use a dependency which does not specify a licence.  A dependency with no licence grants us no rights to distribute what we build.

Further, we must constrain our dependencies to those with licences that we understand.  There are a lot of licences out there, and we can't possibly look at all of them. The majority of candidate dependencies will use one of a small number of licences.  If there is a dependency that you need to use which is only available under a licence that we do not currently list, consult the Engineering Technical Authority.  The Engineering Board may approve a one-off use; or we may choose to update this guidance to advise that the licence in question is suitable for general use.

Dependencies with the following licences are unconditionally acceptable:

- [AFL-3.0](https://opensource.org/license/afl-3-0-php)
- [Apache-2.0](https://opensource.org/license/apache-2-0)
- [BSL-1.0](https://opensource.org/license/BSL-1.0)
- [BSD-2-Clause](https://opensource.org/license/BSD-2-Clause)
- [BSD-3-Clause](https://opensource.org/license/BSD-3-Clause)
- [ECL-2.0](https://opensource.org/license/ecl-2-0)
- [MIT](https://opensource.org/license/MIT)

All of these licences require that the authors of the dependencies are credited when our applications are distributed.

While it is not intended as a software licence, it is not uncommon to encounter dependencies with the [CC0-1.0](https://creativecommons.org/public-domain/cc0/) "No Rights Reserved" licence.  This is also unconditionally acceptable.

Further rules apply, and dependencies with other licence types may be used, depending on the specifics of your project.

### 3.1 If your application is an API-only service

In this case, your application is never distributed to anyone else in either source code or executable form.

#### 3.1.1 If your application is coded in the open, or is to be open source

If your application is being developed in the open, or to be open sourced at release, then you may use dependencies with the following licences under additional constraints:

##### 3.1.1.1 [GPL-2.0](https://opensource.org/license/GPL-2.0)

Your application's source code must be available under the GPL, version 2.0 or later.

##### 3.1.1.2 [GPL-3.0](https://opensource.org/license/GPL-3.0)

Your application's source code must be available under the GPL version 3.0.

##### 3.1.1.3 [LGPL-3.0](https://opensource.org/license/LGPL-3.0)

If your application only uses the interface of the dependency (as would commonly be the case), then there is no obligation.

If your application directly copies the source code of the dependency, then your application's source code must be available under either the GPL version 3.0 or the LGPL version 3.0.

##### 3.1.1.4 [AGPL-3.0](https://opensource.org/license/agpl-v3)

The AGPL is designed to ensure that the source code is available for services made available to the user over a network. We may decide that this is suitable for some of our services: see above.

If your application's source code is already intended to be made available under the AGPL version 3.0, then you may use a dependency with this licence.

#### 3.1.2 If your application is closed source

You may use dependencies licensed under these licences without constraint:

- [GPL-2.0](https://opensource.org/license/GPL-2.0)
- [GPL-3.0](https://opensource.org/license/GPL-3.0)
- [LGPL-3.0](https://opensource.org/license/LGPL-3.0)

You may not use dependencies licensed under the AGPL-3.0.  There may be particular circumstances where legally this may be possible, but it is not practical for us to engage with the specifics.  In this case you should contact the Engineering Technical Authority with a view to obtaining the dependency under a different licence, or identifying a replacement.

### 3.2 If someone else runs your application

In these cases, you are distributing your application to the user at least in executable form, and possibly in source code form too. This distribution means that you may use dependencies with the following licences under additional constraints, _whether or not your application is open or closed source_. If the application you are developing must be closed source, you must either make it open source or refrain from dependencies with these licences:

#### 3.2.1 [GPL-2.0](https://opensource.org/license/GPL-2.0)

Your application's source code must be available under the GPL, version 2.0 or later.

#### 3.2.2 [GPL-3.0](https://opensource.org/license/GPL-3.0)

Your application's source code must be available under the GPL version 3.0.

#### 3.2.3 [LGPL-3.0](https://opensource.org/license/LGPL-3.0)

If your application only uses the interface of the dependency (as would commonly be the case), then there is no obligation.

If your application directly copies the source code of the dependency, then your application's source code must be available under either the GPL version 3.0 or the LGPL version 3.0.

### 3.3 If your application runs in the user's browser

This case is a mix of the previous two: part of the application is a (number, possibly zero, of) API service(s) running on infrastructure you own or control; another part is a (number, at least one, of) user interfaces delivered to the user's browser and running on their computer.

#### 3.3.1 If your application is coded in the open, or is to be open source

##### 3.3.1.1 If your server and client components are distributed together

If you develop both parts together, where the source code for the API component(s) are distributed with the source code for the user interface, you should apply the same licence to both parts.  Multiple licences in the same source code distribution is legally possible but too complex for our purposes.  If you find yourself needing to do this, you should split the distribution into separately-licenced parts.

Where the server and client components are distributed together, you must satisfy licence constraints implied by the dependencies of both. Delivering a client to be executed in the user's browser is legally equivalent to delivering a desktop application, and must follow the same rules: attribution notices must be retained made available as specified in the licences of the dependencies bundled in the client, and the terms of any copyleft licenses must be observed.

The effect of the GPL (version 2.0 or 3.0) is notable here.  A dependency licensed under the GPL that is only used on the server would ordinarily not affect decisions as to which licence to use for the client, but because of the above single-licence rule for where components are distributed together, that is no longer true here.  A dependency licensed under the GPL on the server here requires the whole distribution, including the client, to be made available under the GPL.

##### 3.3.1.2 If your server and client components are distributed separately

Separate distributions enable you to use different licences for the server and the client components, and may incur different responsibilities.  For instance, if you are developing a node.js/React application with a GPL'd dependency which is only used on the server, and which is excluded from the client that the user downloads, then the requirements of the GPL do not apply to the client.

Follow the rules above for an API-only service for the server components, and follow the rules for a desktop app above for the client components.

#### 3.3.2 If your application is closed source

A closed source web application will, with one exceptional licence, only have to be concerned with the dependencies bundled and distributed with the client, for which the rules above in section 3.2 apply.

That exceptional licence is the AGPL. Dependencies licensed under the AGPL should never be used in closed source applications.

## 4. The LGPL: on Linking

The LGPL was created to ensure that a library could be used without the software incorporating it accruing any licensing obligations, while retaining the property from the GPL that the user be able to modify it and substitute their own version.  It expresses this with reference to "object code", "linking", and "headers", which are technical terms relating to the specific details of the C and C++ languages commonly in use among the Free Software communities at the time the LGPL was drafted.  These terms do not have the same meanings in our current preferred development environments, but we can interpret the intent of the licence to arrive at a practical policy through which to clarify our obligations under specific scenarios.

### 4.1 JavaScript on the web

It is our policy that:

- Loading an LGPL'd library unmodified via a `<script>` tag does not result in a work covered by the LGPL, irrespective of where the library is hosted.  The end user can swap our version of the library for their modified version by editing the source of the web page (or employing automation to do so).
- Compiling an LGPL'd library into a bundle downloaded by the browser does result in a work covered by the LGPL. The end user has no direct ability to use their modified version in place of ours, so must be separately provided with that capability under the terms of either the LGPL or the GPL.
- The inclusion of code from an LGPL'd library, modified or not, directly into an application's source code does result in a work covered by the LGPL.
- Where we provide a library for use in the browser, whether or not that

### 4.2 JavaScript on the server (node.js/bun)

It is our policy that:

- Open source applications either that we run or that we provide for others to run should be offered under the terms of the GPLv3 if they incorporate dependencies distributed under the LGPL, as indicated by the [Open Source policy](https://github.com/nhsx/open-source-policy/blob/main/open-source-policy.md).
- Closed source server applications that we run do not incur obligations from dependencies under the LGPL, since the application itself is never conveyed to the user.
- Closed source server applications that we provide for others to run and which have LGPL'd dependencies must be distributed in a format which allows the user to substitute those dependencies for their own versions.  If they cannot, and if we cannot offer the application under the GPLv3, then the LGPL'd dependencies must be replaced or removed.

## 5. What to do when a dependency changes licence

A dependency may change licence between versions, in a way that brings more responsibilities on the consumer.  For instance, a library's author may choose to change its licence from the MIT licence to the GPLv3 from one version to another.  You have the following options:

### 5.1 Comply with the new licence

If the terms of the new licence are not contradicted by any of the above guidance, the simplest option may well be to comply with it.  For instance, a dependency which changes from the MIT licence to the GPLv3 would require relicensing your application under the GPLv3 (or another compatible licence) to adopt the new version, but would require no technical work other than to increment the dependency version as you normally would.

An important exception to this would be where there are secrets within the codebase or its history which cannot be made public.  However, repositories where this is the case _must_ be [made safe](guides/commit-purge.md) regardless of their open or closed source status, so this work needs to be done anyway.

### 5.2 Stay on the old version

Since you received the version you are currently using under a specific licence, your rights to that version under that licence are unaffected by the release of a new version under a new licence.

Remaining on the old version is only applicable for as long as the version you are using remains within security support from the author.  Beyond that point you will need to upgrade anyway, and for the majority of dependencies security patches will not be back-ported to earlier versions.  Therefore this is only a suitable approach in a minority of cases and for a limited time, so if you choose this path you must also make plans to either upgrade and comply with the new licence, or to replace the dependency.

Forking the dependency and attempting to support it ourselves is not a suitable option, because this would prevent the mechanisms which alert us to security problems in our dependencies from functioning correctly.

### 5.3 Replace the dependency

If there are business reasons why you cannot comply with the new licence - if, for instance, the project itself is confidential and its existence cannot yet be made public for commercial reasons - and you cannot stay on the old version because it will not receive security updates or there are new features that you need, then you must replace or remove it.
