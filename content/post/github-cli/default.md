---
autoCollapseToc: true
categories: 
- productivity
contentCopyright: MIT
date: "2021-01-14T00:00:00+08:00"
draft: true
lastmod: "2021-01-14T00:00:00+08:00"
mathjax: true
tags:
- github
- command line
title: Exploring GitHub from the command line
weight: 10
sequenceDiagrams: 
  enable: true
  options: "{theme: 'hand'}"
---

# Overview
Navigating around the GitHub website between various repos/issues etc. is most definitely a time waster. I've decided to dig into the [GitHub CLI](https://github.com/cli/cli). You can install it using [homebrew](https://brew.sh/) with `brew install gh`. Here's a few things I found useful.

# Find issues (and issue #)
I use this [neat little trick](https://github.blog/2013-01-22-closing-issues-via-commit-messages/) to close issues automatically by adding `fixes #33` to a commit message (where 33 is the issue #). This is great! But I often can't remember the issue #, so have to go to the GitHub website, find the issue, etc. which kind of defeats its purpose as a time saver[^1].

There's more to be discovered! See the [full list of commands](https://cli.github.com/manual/) and some resources for setting up [scripts and aliases](https://cli.github.com/manual/#extending-the-cli).

[^1]: although regardless of time spent to achieve this, it's still useful to have the commit referenced in the issue
