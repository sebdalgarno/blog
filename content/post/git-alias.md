---
author: Seb Dalgarno
date: "2021-01-12"
description: A simple use case for setting up a git alias to stage, commit and push all files from RStudio terminal.
tags:
- git
- rstudio
- r
categories: 
- productivity
series: 
- Little productivity boosters
title: Little productivity boosters - git alias
---

## The problem
For years I have staged, committed and pushed changes with the RStudio Git interface.

<img src="https://media.giphy.com/media/IU1hzU7LuKZZhsVsYU/giphy.gif" style="display: block;
  margin-left: auto;
  margin-right: auto;
  width: 80%;"/>
  
It works! But it can be time-consuming when you are doing it a lot. And I've been trying to use my mouse less. It would be better to do this in the terminal.

## The solution
I found [this solution](https://stackoverflow.com/questions/2419249/how-can-i-stage-and-commit-all-files-including-newly-added-files-using-a-singl) on stackoverflow, which suggests staging and committing all files by running the following in the terminal:

```
git add -A && git commit -m "rebuild site"
```
We can push like this:
```
git push
```

However, the real productivity gains are made by using [git aliases](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases), which save us having to type (and remember) full git commands. Let's start with a simple example. To set up the alias `git p` for `git push`, we type in the terminal:
```
git config --global alias.p "push"
```
To set up the alias `git c` for `git commit` we do:
```
git config --global alias.c "commit"
```

Now going back to our previous case of stage/commit all, we can set up the alias `git coa`:
```
git config --global alias.coa "!git add -A && git commit -m"
```

From now on, we can stage, commit and push all changes with two simple commands:
```
git coa 'rebuild site'
```
```
git p
```

Now to completely remove the need to use the mouse, we can set up a customized keyboard shortcut[^1] <kbd>Cmd</kbd>-<kbd>3</kbd> to move the cursor to the RStudio terminal.[^2] The advantage of using the RStudio terminal and not the Terminal app (or iterm2)[^3] is that it is automatically drilled down into the directory of your project.
 
🎉🎉🎉 

[^1]: Check out [this great tutorial](https://support.rstudio.com/hc/en-us/articles/206382178-Customizing-Keyboard-Shortcuts) on customizing keyboard shortcuts in RStudio.
[^2]: I use <kbd>Cmd</kbd>-<kbd>1</kbd> to move cursor to script and <kbd>Cmd</kbd>-<kbd>2</kbd> to move cursor to console.
[^3]: Note that these tips are for Mac users. I'm not sure how to do the above in Windows.

