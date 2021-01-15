---
autoCollapseToc: true
categories: 
- productivity
contentCopyright: MIT
date: "2018-07-10T00:00:00+08:00"
draft: false
lastmod: "2018-07-10T00:00:00+08:00"
mathjax: true
tags:
- alfred
- rstudio
title: Productivity booster - Alfred + .Rproj files
weight: 10
---

# The problem
If you are opening and closing a lot of RStudio projects throughout the day, it's useful to think about the most efficient way to search for and open `.Rproj` files. I want to avoid using my mouse in a Finder window and I find that the default Mac search app Spotlight provides too many results.

# The solution
## Hadley is god
I came across this tip by Hadley Wickham that makes use of the [Alfred](https://www.alfredapp.com/) app[^1].

{{< youtube boKFxBniUH0 >}}

## Installing Alfred
Install Alfred from the [website](https://www.alfredapp.com/) or with homebrew on the command line:
```
brew install --cask alfred
```

## Configuring Alfred for .Rproj
Open Alfred and get into `Preferences -> Features -> Default Results` panel.
![Alfred1](/img/alfred1.png)

Click on `Advanced...` and add the following user-defined file type (by clicking `+`)
```
dyn.ah62d4rv4ge81e6dwr7za
```
![Alfred1](/img/alfred2.png)

I like to open Alfred with the keyboard shortcut <kbd>Cmd</kbd>-<kbd>space</kbd> instead of Spotlight. I followed the instructions [here](https://www.alfredapp.com/help/troubleshooting/cmd-space/) to do this.

Done! Now open Alfred with <kbd>Cmd</kbd>-<kbd>space</kbd> and start typing in the name of a `.Rproj` file. Note you can add other file types for Alfred to look for (e.g. Scrivener projects). A final tip is that if you press <kbd>space</kbd> before typing the file name, Alfred will search all files.

If you are looking for more Mac productivity tips, check out this awesome Twitter thread 
{{< tweet 1333804309272621060 >}}

[^1]: Sorry Windows users, Alfred only available on Mac. But there are other apps for Windows that do similar things.