---
author: Seb Dalgarno
date: "2021-01-12"
description: A simple use case for setting up a git alias to stage, commit and push all files from RStudio terminal.
tags:
- git
- RStudio
- r
series: 
- Workflow
title: Pushing like a dream with git alias
---

For years I have staged, committed and pushed changes with the RStudio Git interface.

<img src="https://media.giphy.com/media/IU1hzU7LuKZZhsVsYU/giphy.gif" style="display: block;
  margin-left: auto;
  margin-right: auto;
  width: 80%;"/>
  
It works! But it can be time-consuming when you are doing it a lot. And I've been trying to use my mouse less. It would be better to do this in the terminal.

I found [this solution](https://stackoverflow.com/questions/2419249/how-can-i-stage-and-commit-all-files-including-newly-added-files-using-a-singl) on stackoverflow, which suggests staging and committing all files by running the following in the terminal:

```
git add -A && git commit -m "rebuild site"
```
We can push like this:
```
git push
```

However, the real wins are gained by using git aliases. To save having to type (and remember) all of the above, we can set up a git alias 'coa' for stage/commit all:
```
git config --global alias.coa "!git add -A && git commit -m"
```
and 'p' for push:
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
