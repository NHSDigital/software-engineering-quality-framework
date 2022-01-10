# Inclusive language

## Context

* This is part of a broader [quality framework](README.md)
* This guidance has been co-authored with the [NHS Digital EMBRACE network](https://digital.nhs.uk/about-nhs-digital/corporate-information-and-documents/staff-networks#ethnic-minorities-broadening-racial-awareness-and-cultural-exchange-embrace-)

## Background

The language and terminology we use is important, and there are certain industry-standard terms which cause hurt and offence. 

In line with organisations such as the [Home Office](https://hodigital.blog.gov.uk/2020/07/23/not-a-black-and-white-issue-using-racially-neutral-terms-in-technology/) and the [National Cyber Security Centre](https://www.ncsc.gov.uk/blog-post/terminology-its-not-black-and-white), we recognise that historically we have used these terms, and we will strive to avoid using these terms in the future.

## Details

| Context                         | Term we will avoid    | Terms we will use instead (suggested) | 
| :------------------------------ | :-------------------- | :------------------------------------ |
| Infrastructure (e.g. databases) | Master                | Primary                               | 
| Infrastructure (e.g. databases) | Slave                 | Replica                               | 
| Source control                  | Master                | Main                                  |
| Network rules                   | Whitelist             | Allowlist / Permitlist                |
| Network rules                   | Blacklist             | Denylist / Blocklist                  |

## Renaming the master branch in github

GitHub have published [guidance](https://github.com/github/renaming) around renaming the master branch. It is worth noting that GitHub retains a history of the names of the parent branch so that existing links to your repository aren't broken - for example the master branch in this repository has been renamed to main, but old links still work [https://github.com/NHSDigital/software-engineering-quality-framework/blob/master/README.md](https://github.com/NHSDigital/software-engineering-quality-framework/blob/master/README.md) and are automatically redirected at the main branch.

In addition to the guidance from GitHub, developers will need to update local copies of a repository if the master branch is renamed - this example is for a renaming from master to main:

```
git branch -m master main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a
```
## Further reading

* [inclusivenaming.org](https://inclusivenaming.org/word-lists/overview/)
* [Internet Engineering Task Force](https://datatracker.ietf.org/doc/draft-knodel-terminology/)
* [Python](https://bugs.python.org/issue34605)
* [GitHub](https://github.com/github/renaming)

