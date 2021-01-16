---
autoCollapseToc: true
categories: 
- productivity
contentCopyright: MIT
date: "2021-01-11T00:00:00+08:00"
draft: false
lastmod: "2021-01-11T00:00:00+08:00"
mathjax: true
tags:
- git
- rstudio
- command line
title: Using a git alias to commit and stage all files
weight: 10
---

**TL;DR** type `git config --global alias.coa "!git add -A && git commit -m"` in the command line. From now on, use `git coa 'message here'` to commit and stage all files!

# Overview
For years I have staged, committed and pushed changes with the RStudio Git interface.

<img src="https://media.giphy.com/media/IU1hzU7LuKZZhsVsYU/giphy.gif" style="display: block;
  margin-left: auto;
  margin-right: auto;
  width: 80%;"/>
  
It works! But I've realized that it's much more efficient (and not hard!) to do from the command line. Check out [this sweet resource by Jenny Bryan](https://happygitwithr.com/) for more info on git with r.

# Git from the command line
[This solution](https://stackoverflow.com/questions/2419249/how-can-i-stage-and-commit-all-files-including-newly-added-files-using-a-singl) on stackoverflow suggests staging, committing and pushing all files by running the following in the command line:

```
git add -A && git commit -m "rebuild site"
git push

```

# Git alias
Real productivity gains are made by using [git aliases](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases), which remove the need to type (and remember) full git commands. Let's start with a simple example. To set up the alias `git p` for `git push`, we run in the command line:
```
git config --global alias.p "push"
```

Going back to our original use case, we can set up the alias `git coa`:
```
git config --global alias.coa "!git add -A && git commit -m"
```

From now on, we can stage, commit and push all changes with two simple commands:
```
git coa 'rebuild site'
git p
```

{{% admonition tip tip %}}
Here are some more useful aliases:

Create and checkout branch
```
git config --global alias.bc "checkout -b"
git bc some_new_branch
```
Delete branch locally and remotely (from [here](https://stackoverflow.com/questions/16740268/git-alias-to-delete-local-and-remote))
```
git config --global alias.bd '!sh -c "git branch -D $1 && git push origin :$1" -'

git bd some_new_branch
```
{{% /admonition %}}

# Keyboard shortcut to Terminal
To completely remove the need to use the mouse, I've set up a customized keyboard shortcut[^1] <kbd>Cmd</kbd>-<kbd>3</kbd> to move the cursor to the RStudio Terminal. Check out [this great tutorial](https://support.rstudio.com/hc/en-us/articles/206382178-Customizing-Keyboard-Shortcuts) on customizing keyboard shortcuts in RStudio. The advantage of using the RStudio terminal and not the MacOS Terminal app (or iterm2)[^3] is that it is automatically drilled down into the directory of your project.
 
🎉🎉🎉 

[^1]: I also use <kbd>Cmd</kbd>-<kbd>1</kbd> to move cursor to script and <kbd>Cmd</kbd>-<kbd>2</kbd> to move cursor to console.
[^3]: These tips are for Mac users. I'm not sure how to do the above in Windows.

