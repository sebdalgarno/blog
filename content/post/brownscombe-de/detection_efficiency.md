---
title: "Accounting for detection range variation in acoustic telemetry arrays"
output: hugodown::md_document
date: 2021-04-08T16:19:13-07:00
lastmod: 2021-04-08T16:19:13-07:00
draft: true
keywords: []
description: ""
tags: ["acoustic telemetry", "analysis", "detection error"]
categories: ["acoustic telemetry"]
author: "Seb"
comment: true
toc: false
autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false
contentCopyright: false
reward: false
mathjax: false
mathjaxEnableSingleDollar: false
mathjaxEnableAutoNumber: false
hideHeaderAndFooter: false
flowchartDiagrams:
  enable: false
  options: ""
sequenceDiagrams: 
  enable: false
  options: ""
rmd_hash: 18cd3915fe7769b4

---

I have been reading [this great paper](https://besjournals.onlinelibrary.wiley.com/doi/abs/10.1111/2041-210X.13322) by Jacob Brownscombe et al., which outlines a practical approach to accounting for detection range (DR) variation in acoustic telemetry arrays. I am a little ashamed to say that this is something I haven't thought a lot about, despite working with acoustic telemetry data a fair bit. As an example of the pitfalls of failing to account for variation in DR, Brownscombe points to a study by Payne et al. (2010) on the diel patterns in use of nearshore habitats by cuttlefish. Whereas the raw data showed that cuttlefish used these areas more during the day, the corrected data showed that they used these areas more at night. Not only did this affect the effect size, but it completely changed the directionality of the effect, which fundamentally changes our understanding of the species biology and how to manage them!

# Why is there variation in detection range?

In acoustic telemetry studies, we typically set up an array of stationary receivers within a study area and tag some animals with acoustic transmitters. These animals (let's say fish) swim around sending out supersonic acoustic transmissions every few seconds. When the fish passes within the receivers detection range, the receiver records the unique id of the transmitter and time of detection. So far, pretty straightforward (at least from a data perspective, not logistically!) The tricky part is that **detection efficiency (DE) decreases with distance from receiver and the DR for each receiver varies in space and time**.

So what causes this variation?  
First, these acoustic signals may never reach the receiver as they can be:

1.  attenuated, retracted, or lost due to spreading in water.  
2.  disrupted by physical barriers.  
3.  muted by environmental or biological noise.

Second, the signal could be wrongly interpreted by the receiver (i.e. false detection) if:  
1. tags are mutated by noise but still decoded by a receiver.  
1. tags operating on the same frequemcy collide with one another and arrive at the receiver simultaneously.

These are imperfect sampling systems that are affected by conditions in the surrounding environment (e.g. rugosity, depth, anthropogenic or environmental noise) and how many other tags exist in the study area (with more tags leading to less DE).

# How do we deal with this variation to correct our analyses?

Frist some definitions:  
- **DR** - the 3-dimensional space surrounding a receiver that a transmitter can be detected in  
- **DE** (%) - \# detections in given time period / total expected detections based on transmission rate \* 100  
- **MR** - estimated distance from receiver with 5% DE  
- **Midpoint** - estimated distance from receiver with 50% DE  
- **DEv** - difference between detection efficiency in given time period and mean detection efficiency of reference tag  
- **DEvc** - DEv standardized to +/- 50% (across receivers)  
- **DRc** - DR correction facto derived from MR and DEvc  
- **Det** - number of detections  
- **Detc** - number of detections corrected using DRc

Brownscombe suggests a practical approach to deal with this issue:  
1. **Select a set of sentinel receivers** that represent the full range of environmental conditions (these will be used to predict DE at the rest of the receivers) and measure/record site characteristics in space (e.g. depth, benthos) and time (e.g. tide, diel period).  
1. **Quantify the MR and Midpoint** at each sentinel receiver. This can be done by dropping a tag at various distances from a receiver, measuring DE and modelling the relationship between efficiency and distance to estimate the Midpoint and MR.  
1. **Quanitfy the variance in DE** (DEv) at each sentinel receiver. This is done by dropping a reference tag (i.e., tag with longer transmission delay \~200-700 seconds) at the Midpoint (e.g. 200m away) and leaving it there for the duration of the study.  
1. **Calculate detection range correction factor** (DRc). This uses DEv and MR.  
1. **Model relationship between DRc and site characteristics** to predict DRc at other receivers in array.  
1. **Correct detection data** using predicted DRc.

To make this process more clear, I'll simulate some data and show the R code to calculate each step. Note that I referenced the code provided in Brownscombe et al. supplementary info, but have modified it quite a bit.

# Calculate Midpoint and MR

Step 1: Create some fake receivers at different depths, half of which are sentinels.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>nrec</span> <span class='o'>&lt;-</span> <span class='m'>16</span>
<span class='nf'><a href='https://rdrr.io/r/base/Random.html'>set.seed</a></span><span class='o'>(</span><span class='m'>99</span><span class='o'>)</span>

<span class='nv'>rec</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/data.frame.html'>data.frame</a></span><span class='o'>(</span>receiver <span class='o'>=</span> <span class='m'>1</span><span class='o'>:</span><span class='nv'>nrec</span>,
             depth <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/stats/Uniform.html'>runif</a></span><span class='o'>(</span><span class='nv'>nrec</span>, <span class='m'>5</span>, <span class='m'>20</span><span class='o'>)</span>,
             sentinel <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='kc'>TRUE</span>, <span class='kc'>FALSE</span><span class='o'>)</span><span class='o'>)</span>
<span class='nv'>rec</span>
<span class='c'>#&gt;    receiver     depth sentinel</span>
<span class='c'>#&gt; 1         1 13.770678     TRUE</span>
<span class='c'>#&gt; 2         2  6.706725    FALSE</span>
<span class='c'>#&gt; 3         3 15.263971     TRUE</span>
<span class='c'>#&gt; 4         4 19.887632    FALSE</span>
<span class='c'>#&gt; 5         5 13.024904     TRUE</span>
<span class='c'>#&gt; 6         6 19.499211    FALSE</span>
<span class='c'>#&gt; 7         7 15.071413     TRUE</span>
<span class='c'>#&gt; 8         8  9.418666    FALSE</span>
<span class='c'>#&gt; 9         9 10.375445     TRUE</span>
<span class='c'>#&gt; 10       10  7.629721    FALSE</span>
<span class='c'>#&gt; 11       11 13.232261     TRUE</span>
<span class='c'>#&gt; 12       12 12.581776    FALSE</span>
<span class='c'>#&gt; 13       13  7.907547     TRUE</span>
<span class='c'>#&gt; 14       14 14.553562    FALSE</span>
<span class='c'>#&gt; 15       15 15.317001     TRUE</span>
<span class='c'>#&gt; 16       16 14.602862    FALSE</span></code></pre>

</div>

Step 2: Simulate some detection range data, where depth has an effect on the DE curve.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ggplot2.tidyverse.org'>ggplot2</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://poissonconsulting.github.io/extras/'>extras</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='http://purrr.tidyverse.org'>purrr</a></span><span class='o'>)</span>

<span class='nv'>dr</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_df</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/seq.html'>seq_along</a></span><span class='o'>(</span><span class='nv'>rec</span><span class='o'>$</span><span class='nv'>receiver</span><span class='o'>[</span><span class='nv'>rec</span><span class='o'>$</span><span class='nv'>sentinel</span><span class='o'>]</span><span class='o'>)</span>, <span class='kr'>function</span><span class='o'>(</span><span class='nv'>x</span><span class='o'>)</span><span class='o'>&#123;</span>
  <span class='nv'>df</span> <span class='o'>&lt;-</span> <span class='nv'>rec</span><span class='o'>[</span><span class='nv'>x</span>,<span class='o'>]</span>
  
  <span class='nv'>distance</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/seq.html'>seq</a></span><span class='o'>(</span><span class='m'>0</span>, <span class='m'>500</span>, <span class='m'>60</span><span class='o'>)</span>
  <span class='nv'>b0</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://poissonconsulting.github.io/extras/reference/logit.html'>logit</a></span><span class='o'>(</span><span class='m'>0.99</span><span class='o'>)</span>
  <span class='nv'>bDist</span> <span class='o'>&lt;-</span> <span class='o'>-</span><span class='m'>0.027</span>   
  <span class='nv'>bDepth</span> <span class='o'>&lt;-</span> <span class='m'>0.2</span>
  <span class='nv'>z</span> <span class='o'>&lt;-</span> <span class='nv'>b0</span> <span class='o'>+</span> <span class='nv'>bDist</span> <span class='o'>*</span> <span class='nv'>distance</span> <span class='o'>+</span> <span class='nv'>bDepth</span> <span class='o'>*</span> <span class='nv'>df</span><span class='o'>$</span><span class='nv'>depth</span> 
  <span class='nv'>pr</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://poissonconsulting.github.io/extras/reference/ilogit.html'>ilogit</a></span><span class='o'>(</span><span class='nv'>z</span><span class='o'>)</span>
  
  <span class='nv'>nsample</span> <span class='o'>&lt;-</span> <span class='m'>50</span>
  <span class='nv'>success</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/stats/Binomial.html'>rbinom</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>1</span>, <span class='nf'><a href='https://rdrr.io/r/base/length.html'>length</a></span><span class='o'>(</span><span class='nv'>pr</span><span class='o'>)</span><span class='o'>)</span>, <span class='nv'>nsample</span>, <span class='nv'>pr</span><span class='o'>)</span>
  <span class='nv'>failure</span> <span class='o'>&lt;-</span> <span class='nv'>nsample</span> <span class='o'>-</span> <span class='nv'>success</span>
  <span class='nv'>de</span> <span class='o'>&lt;-</span> <span class='nv'>success</span><span class='o'>/</span><span class='nv'>nsample</span>
  
  <span class='nv'>dr</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/data.frame.html'>data.frame</a></span><span class='o'>(</span>receiver <span class='o'>=</span> <span class='nv'>x</span>,
               depth <span class='o'>=</span> <span class='nv'>df</span><span class='o'>$</span><span class='nv'>depth</span>,
               distance <span class='o'>=</span> <span class='nv'>distance</span>,
               success  <span class='o'>=</span> <span class='nv'>success</span>,
               failure <span class='o'>=</span> <span class='nv'>failure</span>,
               de <span class='o'>=</span> <span class='nv'>de</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span>

<span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span>data <span class='o'>=</span> <span class='nv'>dr</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='nv'>distance</span>, y <span class='o'>=</span> <span class='nv'>de</span><span class='o'>*</span><span class='m'>100</span>, color <span class='o'>=</span> <span class='nv'>depth</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/facet_wrap.html'>facet_wrap</a></span><span class='o'>(</span><span class='o'>~</span><span class='nv'>receiver</span><span class='o'>)</span> <span class='o'>+</span> 
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/labs.html'>labs</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='s'>"Distance from Receiver (m)"</span>, y <span class='o'>=</span> <span class='s'>"Detection Efficiency (%)"</span><span class='o'>)</span>
</code></pre>
<img src="figs/dr_plot-1.png" width="700px" style="display: block; margin: auto;" />

</div>

We can estimate the Midpoint and MR for each sentinel receiver by modelling the relationship between DE and distance for each receiver. Here, we use a generalized linear model with binomial family (logistic regression), although Brownscombe et al. used a third-order polynomial liner regression with forced y-intercept at 1.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># create models for each sentinel receiver</span>
<span class='nv'>rec</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/unique.html'>unique</a></span><span class='o'>(</span><span class='nv'>dr</span><span class='o'>$</span><span class='nv'>receiver</span><span class='o'>)</span>
<span class='nv'>models</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map</a></span><span class='o'>(</span><span class='nv'>rec</span>, <span class='kr'>function</span><span class='o'>(</span><span class='nv'>x</span><span class='o'>)</span><span class='o'>&#123;</span>
  <span class='nv'>dat</span> <span class='o'>&lt;-</span> <span class='nv'>dr</span><span class='o'>[</span><span class='nv'>dr</span><span class='o'>$</span><span class='nv'>receiver</span> <span class='o'>==</span> <span class='nv'>x</span>,<span class='o'>]</span>
  <span class='nf'><a href='https://rdrr.io/r/stats/glm.html'>glm</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/cbind.html'>cbind</a></span><span class='o'>(</span><span class='nv'>success</span>, <span class='nv'>failure</span><span class='o'>)</span> <span class='o'>~</span> <span class='nv'>distance</span>, data <span class='o'>=</span> <span class='nv'>dat</span>, family <span class='o'>=</span> <span class='s'>"binomial"</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span> <span class='o'>%&gt;%</span> <span class='nf'><a href='https://purrr.tidyverse.org/reference/set_names.html'>set_names</a></span><span class='o'>(</span><span class='nv'>rec</span><span class='o'>)</span>

<span class='c'># function to calculate distance for a desired DE value</span>
<span class='nv'>calc_distance_at_de</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='nv'>model</span>, <span class='nv'>value</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nv'>find_int</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='nv'>model</span>, <span class='nv'>value</span><span class='o'>)</span> <span class='o'>&#123;</span>
    <span class='kr'>function</span><span class='o'>(</span><span class='nv'>x</span><span class='o'>)</span><span class='o'>&#123;</span>
      <span class='nf'><a href='https://rdrr.io/r/stats/predict.html'>predict</a></span><span class='o'>(</span><span class='nv'>model</span>, <span class='nf'><a href='https://rdrr.io/r/base/data.frame.html'>data.frame</a></span><span class='o'>(</span>distance <span class='o'>=</span> <span class='nv'>x</span><span class='o'>)</span>, type <span class='o'>=</span> <span class='s'>"response"</span><span class='o'>)</span> <span class='o'>-</span> <span class='nv'>value</span>
    <span class='o'>&#125;</span>
  <span class='o'>&#125;</span>
  <span class='nf'><a href='https://rdrr.io/r/stats/uniroot.html'>uniroot</a></span><span class='o'>(</span><span class='nf'>find_int</span><span class='o'>(</span><span class='nv'>model</span>, <span class='nv'>value</span><span class='o'>)</span>, <span class='nf'><a href='https://rdrr.io/r/base/range.html'>range</a></span><span class='o'>(</span><span class='nv'>dr</span><span class='o'>$</span><span class='nv'>distance</span><span class='o'>)</span><span class='o'>)</span><span class='o'>$</span><span class='nv'>root</span>
<span class='o'>&#125;</span>

<span class='c'># sequence of distance values to predict DE on</span>
<span class='nv'>distvals</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/seq.html'>seq</a></span><span class='o'>(</span><span class='m'>0</span>, <span class='m'>600</span>, <span class='m'>1</span><span class='o'>)</span>

<span class='c'># for each receiver and it's respective model, predict over range of distance values and </span>
<span class='c'># estimate Midpoint and MR</span>
<span class='nv'>preds</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_df</a></span><span class='o'>(</span><span class='nv'>rec</span>, <span class='kr'>function</span><span class='o'>(</span><span class='nv'>x</span><span class='o'>)</span><span class='o'>&#123;</span>
  <span class='nv'>predvals</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/stats/predict.html'>predict</a></span><span class='o'>(</span><span class='nv'>models</span><span class='o'>[[</span><span class='nv'>x</span><span class='o'>]</span><span class='o'>]</span>, <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>distance <span class='o'>=</span> <span class='nv'>distvals</span><span class='o'>)</span>, type <span class='o'>=</span> <span class='s'>"response"</span><span class='o'>)</span>
  <span class='nv'>midpoint</span> <span class='o'>&lt;-</span> <span class='nf'>calc_distance_at_de</span><span class='o'>(</span><span class='nv'>models</span><span class='o'>[[</span><span class='nv'>x</span><span class='o'>]</span><span class='o'>]</span>, <span class='m'>0.5</span><span class='o'>)</span>
  <span class='nv'>mr</span> <span class='o'>&lt;-</span> <span class='nf'>calc_distance_at_de</span><span class='o'>(</span><span class='nv'>models</span><span class='o'>[[</span><span class='nv'>x</span><span class='o'>]</span><span class='o'>]</span>, <span class='m'>0.05</span><span class='o'>)</span>
  <span class='nf'><a href='https://rdrr.io/r/base/data.frame.html'>data.frame</a></span><span class='o'>(</span>receiver <span class='o'>=</span> <span class='nv'>x</span>,
             distance <span class='o'>=</span> <span class='nv'>distvals</span>,
             predvals <span class='o'>=</span> <span class='nv'>predvals</span>,
             midpoint <span class='o'>=</span> <span class='nv'>midpoint</span>,
             mr <span class='o'>=</span> <span class='nv'>mr</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span>

<span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span>data <span class='o'>=</span> <span class='nv'>dr</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='nv'>distance</span>, y <span class='o'>=</span> <span class='nv'>de</span><span class='o'>*</span><span class='m'>100</span>, color <span class='o'>=</span> <span class='nv'>depth</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_path.html'>geom_line</a></span><span class='o'>(</span>data <span class='o'>=</span> <span class='nv'>preds</span>, <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='nv'>distance</span>, y <span class='o'>=</span> <span class='nv'>predvals</span><span class='o'>*</span><span class='m'>100</span><span class='o'>)</span>, colour<span class='o'>=</span><span class='s'>"black"</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span>data <span class='o'>=</span> <span class='nv'>preds</span>, <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='nv'>midpoint</span>, y <span class='o'>=</span> <span class='m'>50</span><span class='o'>)</span>, color <span class='o'>=</span> <span class='s'>"red"</span>, size <span class='o'>=</span> <span class='m'>2</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span>data <span class='o'>=</span> <span class='nv'>preds</span>, <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='nv'>mr</span>, y <span class='o'>=</span> <span class='m'>5</span><span class='o'>)</span>, color <span class='o'>=</span> <span class='s'>"red"</span>, size <span class='o'>=</span> <span class='m'>2</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/facet_wrap.html'>facet_wrap</a></span><span class='o'>(</span><span class='o'>~</span><span class='nv'>receiver</span><span class='o'>)</span> <span class='o'>+</span> 
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/labs.html'>labs</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='s'>"Distance from Receiver (m)"</span>, y <span class='o'>=</span> <span class='s'>"Detection Efficiency (%)"</span><span class='o'>)</span>
</code></pre>
<img src="figs/dr_model-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Now that we've calculated our Midpoints for each sentinel, let's put a reference tag there to calculate DE over time. We'll simulate some data where DE has a positive relationship with day and the magnitude of the effect increases with depth. This is not very realistic (a seasonal effect would be better and I don't know if influence of depth is a realistic mechanism) but it'll work just for demonstration purposes.

