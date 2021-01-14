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

## Selecting a theme
I made this blog with [blogdown](https://bookdown.org/yihui/blogdown/). blogdown is an R package by the awesome [Yihui Xie](https://yihui.org/en/about/) that allows you to combine [Hugo](https://gohugo.io/) and Rmarkdown. For example, if you check out Joe Thorley's [sweet blog](https://www.joethorley.io/) and [this post](https://www.joethorley.io/post/2019/exponential-growth/), you can see that it is great for demonstrating R code and generating output from that code to explain analyses and statistical concepts. Even if you aren't using R though, it is just really sweet to make posts in plain markdown. 

I spent a while choosing a theme and eventually settled on Yihui's [hugo-ivy theme](https://github.com/yihui/hugo-ivy). I wanted something minimal but with solid technical and R-friendly formatting capabilities. Note, the [Academic theme](https://themes.gohugo.io/academic/), which I used for my [consulting website](https://northbeachconsulting.ca/), is very popular and a great choice If you are looking for something that will definitely 'just work', is very customizable and is well-documented.

## Modifying the theme
Here are some minor modifications I made to the hugo-ivy theme.

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
the colour of the title and subtitle,
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
and changed the color and margin of the timestamps next to the blog titles by adding CSS via the style argument in `./themes/hugo-ivy/layouts/partials/list.html`(since the date class did not appear to exist in `style.css` file).

```html
<ul>
  {{ range (where ($.Scratch.Get "pages") "Section" "!=" "") }}
  <li style="margin-bottom: 1em;">
    <span class="date" style="color: #6B7280; margin-right: 1rem;
">{{ .Date.Format "2006/01/02" }}</span>
    <a href="{{ .RelPermalink }}">{{ .Title }}</a>
  </li>
  {{ end }}
</ul>
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
