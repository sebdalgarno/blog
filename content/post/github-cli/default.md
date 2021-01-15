---
autoCollapseToc: true
categories: 
- productivity
contentCopyright: MIT
date: "2021-01-14T00:00:00+08:00"
draft: false
lastmod: "2021-01-14T00:00:00+08:00"
mathjax: true
tags:
- github
- command line
title: Productivity booster - GitHub from the command line
weight: 10
sequenceDiagrams: 
  enable: true
  options: "{theme: 'hand'}"
---

{{% admonition abstract abstract %}}
biu biu biu.
{{% /admonition %}}

```flow
st=>start: Start|past:>http://www.google.com[blank]
e=>end: End:>http://www.google.com
op1=>operation: My Operation|past
op2=>operation: Stuff|current
sub1=>subroutine: My Subroutine|invalid
cond=>condition: Yes
or No?|approved:>http://www.google.com
c2=>condition: Good idea|rejected
io=>inputoutput: catch something...|request

st->op1(right)->cond
cond(yes, right)->c2
cond(no)->sub1(left)->op1
c2(yes)->io->e
c2(no)->op2->e
```

hi
```sequence
Title: Here is a title
A->B: Normal line
B-->C: Dashed line
C->>D: Open arrow
D-->>A: Dashed open arrow
```

# The problem
I find myself navigating around the GitHub site between various repos/issues etc. This requires too much mouse use and [context switching](https://www.cognoshr.com/knowledge/2018/7/10/context-switching-the-ever-present-productivity-killer-and-what-you-can-do-to-keep-it-at-bay#:~:text=Context%20switching%20states%20that%20every,nearly%20half%20of%20your%20time.) when many of these tasks could be done from the command line. 

# The solution
[GitHub command line interface (cli)](https://cli.github.com/) `gh`. You can see the full list of commands [here](https://cli.github.com/manual/) and some resources for setting up scripts and aliases [here](https://cli.github.com/manual/#extending-the-cli) but I'll go over a few things that I've started to use recently.

