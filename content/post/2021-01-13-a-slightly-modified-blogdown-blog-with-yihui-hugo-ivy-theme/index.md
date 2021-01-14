---
title: A (slightly modified) blogdown blog with hugo-ivy theme
author: Seb
date: '2021-01-13'
slug: a-slightly-modified-blogdown-blog-with-yihui-hugo-ivy-theme
categories:
  - blog
series:
  - blogdown
tags:
  - blogdown
  - css
  - web development
  - r
---

I made this blog with [blogdown](https://bookdown.org/yihui/blogdown/). blogdown is an R package by the awesome [Yihui Xie](https://yihui.org/en/about/) that allows you to combine [Hugo](https://gohugo.io/) and Rmarkdown. For example, if you check out Joe Thorley's [sweet blog](https://www.joethorley.io/) and [this post](https://www.joethorley.io/post/2019/exponential-growth/) for example, you can see that it is great for demonstrate R code and generate output from that code to explain analyses and statistical concepts. Even if you aren't using R though, it is just really sweet to make posts in plain markdown. 

I spent a while choosing a theme and eventually settled on yihui's [hugo-ivy theme](https://github.com/yihui/hugo-ivy). Note there is no documentation for this theme so it is useful to have a bit of web development experience if you want to customize things. The [Academic theme](https://themes.gohugo.io/academic/) is the most popular Hugo theme and is much better documented/battle-worn if you are looking for something that will most definitely work and that is very customizable with plenty of documentation. That is what I built my [consulting website](https://northbeachconsulting.ca/) with.

I'll briefly go over some minor modifications I made to the hugo-ivy theme.

First, to make any changes to the CSS you have to find the .css files! These live in `./themes/hugo-ivy/static/css/`.
I changed the text font to Roboto in the `fonts.css` file
```css
body {
  font-family: Roboto, 'Lucida Sans', Calibri, Candara, Arial, 'source-han-serif-sc', 'Source Han Serif SC', 'Source Han Serif CN', 'Source Han Serif TC', 'Source Han Serif TW', 'Source Han Serif', 'Songti SC', 'Microsoft YaHei', sans-serif;
}
```
the CSS of the links (line and text color, hover background),
```css
a {
  color: #111827;
  text-decoration: none;
  padding-bottom: 2px;
  border-bottom: 1px solid #9CA3AF;
}

a:hover {
  background-color: #F3F4F6;
  border-radius: 0.3rem;
}
```
and the colour of the title and subtitle.
```css
.masthead .tagline {
  color: #4B5563;
  text-align: right;
}
.subtitle {
  font-size: .9em;
  color: #6B7280;
}
```

I grabbed colour hex codes from [Tailwind CSS](https://tailwindcss.com/docs/customizing-colors) which I find has a really nice cool (i.e. blue-tinted) grey palette.

Finally, I added emojis into the title by modifying `./themes/hugo-ivy/layouts/partials/tagline.html`
```html
<h1><a href="{{ relURL "/" }}" style="color: #111827;">{{ .Site.Title | emojify }}</a></h1>
```
Note the ` | emojify` part. I then modified the `config.yaml` file `title` to
```yaml
title: ":fish: Fishy Data :fishing_pole_and_fish:"
```
where the emojis are defined like this: \:fish\:

I probably forgot one or two things, but that's basically it! Here is how the [default theme](https://ivy.yihui.org/) looks, by the way:

![hugo-ivy](/img/hugo-ivy.png)

Better I think? Who knows, maybe I jsut wasted a couple hours...but at least I learned a bit more about how Hugo themes work.
