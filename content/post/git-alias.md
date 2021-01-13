---
author: Seb Dalgarno
date: "2021-01-12"
description: A simple use case for setting up a git alias to stage, commit and push all files from RStudio terminal.
tags:
- git
- RStudio
- R
title: Pushing like a dream with git alias
---

For years I have staged, committed and pushed via the RStudio Git interface. It works! But it can be time-consuming when you are doing it a lot. And it's not very dreamy. And I've been trying to use my mouse less. It would be better to do this in the terminal.

<img src="https://media.giphy.com/media/V2nkKhmFoblp408Ar9/giphy.gif" style="display: block;
  margin-left: auto;
  margin-right: auto;
  width: 80%;"/>

While searching for a solution, I stumbled across [this stack overflow question](https://stackoverflow.com/questions/2419249/how-can-i-stage-and-commit-all-files-including-newly-added-files-using-a-singl), which suggests doing this from the command line to stage and commit all files

```
git add -A && git commit -m "rebuild site"
```
and push
```
git push
```

To save having to type (and remember) all of this, we can set up a git alias. In the terminal, type
```
git config --global alias.coa "!git add -A && git commit -m"
```
The alias 'coa' can now be used for staging and committing all files. We can also set up an alias - p - for pushing

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

To make this even dreamier I set up a customized keyboard shortcut[^1] <kbd>Cmd</kbd>-<kbd>3</kbd> to move my cursor to the RStudio terminal.[^2] The advantage of using the RStudio terminal and not your regular terminal (or iterm2) is that it is automatically drilled down into the directory of your project (hence, switching between projects does not require moving into another directory).
 
No more using the mouse! 🎉🎉🎉 

[^1]: Check out [this great tutorial](https://support.rstudio.com/hc/en-us/articles/206382178-Customizing-Keyboard-Shortcuts) on customizing keyboard shortcuts in RStudio.
[^2]: I use <kbd>Cmd</kbd>-<kbd>1</kbd> to move cursor to script and <kbd>Cmd</kbd>-<kbd>2</kbd> to move cursor to console.
