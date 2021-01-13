---
author: Seb Dalgarno
date: "2021-01-12"
description: A simple use case for setting up a git alias to stage, commit and push all files from RStudio terminal.
tags:
- git
- RStudio
- R
title: Git aliases - push like a dream
---

For years I have staged, committed and pushed via the RStudio Git interface. It works! But it can be time-consuming when you are doing it a lot. I've also been trying to use my mouse less. My breaking point to find an alternative method was while building this blog (blogdown R package). Every time `blogdown::build_site()` is run many files are changed, all of which can be staged, committed and pushed at once without much thought. 

<img src="https://media.giphy.com/media/V2nkKhmFoblp408Ar9/giphy.gif" width="500" height="500"/>

I stumbled across [this stack overflow question](https://stackoverflow.com/questions/2419249/how-can-i-stage-and-commit-all-files-including-newly-added-files-using-a-singl), which suggests doing this from the command line to stage and commit all files

```
git add -A && git commit -m "rebuild site"
```
and push
```
git push
```

A better way to do this is to set up a git alias. In the terminal, type
```
git config --global alias.coa "!git add -A && git commit -m"
```
This sets up an alias - coa - for staging and committing all files. We can also set up an alias - p - for pushing like this:

```
git config --global alias.p "push"
```

From now on (and forever), we can stage, commit and push all changes with two simple commands:
```
git coa 'rebuild site'
```
```
git p
```

To make this even smoother I set up a customized keyboard shortcut (see [here](https://support.rstudio.com/hc/en-us/articles/206382178-Customizing-Keyboard-Shortcuts) for more info) <kbd>Cmd</kbd>-<kbd>3</kbd> to jump my cursor to the RStudio terminal. The advantage of using the RStudio terminal and not your regular terminal (or iterm2) is that it is automatically drilled down into the directory of your project (hence, switching between projects does not require moving into another directory).
 
No more using the mouse! 🎉🎉🎉 