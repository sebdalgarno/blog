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
Navigating around the GitHub website between various repos/issues etc. is most definitely a time waster. I've decided to dig into the [GitHub CLI](https://github.com/cli/cli). You can install it using [homebrew](https://brew.sh/) with `brew install gh` and authorize it by running `gh auth login` in the command line (more info in [this manual](https://cli.github.com/manual/)). Here's a few things I found useful.

# Dealing with issues

## List issues
Once you are drilled down into the project directory in the command line (or simply go to Terminal in an RStudio project), type the following:
```
gh issue list

# Showing 3 of 3 open issues in sebdalgarno/blog
# 
# #6  add shortcodes                     about 1 day ago
# #5  get RSS button working             about 1 day ago
# #2  not rendering Rmd                  about 2 days ago
```

## View issues
As I'm writing this I realize that I've already solved #2. I'll view it just to make sure.

```
gh issue view 2

# not rendering Rmd
# Open • sebdalgarno opened about 2 days ago • 0 comments
# 
# 
#   blogdown problem as other themes also not working                           
# 
# 
# View this issue on GitHub: https://github.com/sebdalgarno/blog/issues/2
```
## Close issues
Yes! this was solved by moving to [hugodown](https://hugodown.r-lib.org/). I'll close it.

```
gh issue close 2
# ✔ Closed issue #2 (not rendering Rmd)
```

As an aside, I use this [neat little trick](https://github.blog/2013-01-22-closing-issues-via-commit-messages/) to close issues automatically by adding `fixes #33` to a commit message (where 33 is the issue #). `gh issue list` is going to be super helpful to find the issue #.

## Create issues
I'll create an issue to finish this post. I am being a little hard on myself here (since I'm already working on it!), but I really should finish this post. 

```
gh issue create --title "Finish GitHub CLI post" --body "Seriously, do it."

# Creating issue in sebdalgarno/blog
# 
# https://github.com/sebdalgarno/blog/issues/9
```
and confirm:
```
gh issue list

# Showing 3 of 3 open issues in sebdalgarno/blog
#
# #9  Finish GitHub CLI post             about 1 minute ago
# #6  add shortcodes                     about 1 day ago
# #5  get RSS button working             about 1 day ago
```

# Dealing with pull requests
## Create changes on a branch
I'm going to create a branch called 'fix_that_bug' and fix that bug (you know, *that* one). Then I'll commit and push those changes. 

```
git cb fix_that_bug
# Switched to a new branch "fix_that_bug"

git coa 'fixed it'
[fix_that_bug 35457d9] fixed it
 1 file changed, 3 insertions(+), 1 deletion(-)
 
git p
```
{{% admonition tip tip %}}
If the above git commands look strange that's because they're aliases! Check out my [post on git alias](https://fishydata.netlify.app/post/git-alias/) for details.
{{% /admonition %}}

## Create pull request and merge
Now I'll create a pull request with `gh`,
```
gh pr create --title "fixed it" --body "good lord that took me 35 hours" 

# ? Where should we push the 'fix_that_bug' branch? sebdalgarno/blog
#
# Creating pull request for fix_that_bug into master in sebdalgarno/blog
#
# remote: 
# remote: 
# To github.com:sebdalgarno/blog.git
#  * [new branch]      HEAD -> fix_that_bug
# Branch 'fix_that_bug' set up to track remote branch 'fix_that_bug' from 'origin'.
# https://github.com/sebdalgarno/blog/pull/12
```
check the diff (<kbd>Ctrl</kbd>-<kbd>c</kbd> to quit process)
```
gh pr diff 12
```
merge it,
```
gh pr merge 12
# ? What merge method would you like to use? Create a merge commit
# ? Delete the branch locally and on GitHub? Yes
# ? Submit? Yes
# ✔ Merged pull request #12 (fixed it)
# ✔ Deleted branch fix_that_bug and switched to branch master
```
and pull into local master (or main) branch.
```
git pull
```

That's it for now!

Oh ya one more thing
```
gh issue close 9
# ✔ Closed issue #9 (Finish GitHub CLI post)
```

{{% admonition tip tip %}}
See the [full list of commands and examples](https://cli.github.com/manual/examples.html) and some resources for setting up [scripts and aliases](https://cli.github.com/manual/#extending-the-cli).
{{% /admonition %}}

[^1]: although regardless of time spent to achieve this, it's still useful to have the commit referenced in the issue
