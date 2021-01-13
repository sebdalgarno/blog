---
author: Seb Dalgarno
date: "2021-01-12"
description: A simple use case for git alias to stage all, commit and push from RStudio terminal.
tags:
- markdown
- text
title: Git aliases - they're great
---

For years I have staged, committed and pushed via the RStudio Git interface. It works! But it can be time-consuming when you are doing it a lot. My breaking point to find an alternative method was actually building this blog with the blogdown R package. Every time `blogdown::build_site()` is run many files are changed, all of which can be staged, commited and pushed at once without much further thought. 

I stumbled across [this stack overflow question](https://stackoverflow.com/questions/2419249/how-can-i-stage-and-commit-all-files-including-newly-added-files-using-a-singl), which suggests using git aliases.