---
title: "Fish and Nathan's movement ecology paradigm"
date: 2021-04-09T15:11:11-07:00
output: hugodown::md_document
lastmod: 2021-04-09T15:11:11-07:00
draft: true
keywords: []
description: ""
tags: []
categories: []
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
rmd_hash: b1016886471c5b51

---

This is a reflection on how the ideas presented in Nathan et al.'s 2008 paper 'A movement ecology paradigm for unifying organismal movement research' might be applied to the study of fish movement from acoustic telemetry.

The study of animal movement has advanced a lot in recent years. Nathan suggests that advancements in animal tracking technology, environmental monitoring, and analytical methods (i.e. from increased computational power) have led to a general shift from the study of population redistribution (Eularian approach) to the study of individuals (Lagrangian approach). This has enabled development of more complex models (e.g. state-space models for individual animal movement) and increased understanding. However, Nathan suggests that a common framework is necessary to unify several paradigms for animal movement (i.e. biomechanical, cognitive, random, optimality) that are operating parallel to one another.

In this attempt to unify the study of animal movement, Nathan's paper suggests that there are four overarching questions (note Nathan is talking generally about organismal movement, but I will narrow this down a bit to animals):  
1. Why do animals move?  
2. How do animals move?  
3. When and where do animals move?  
4. What are the external factors driving animal movement?

Following from this, Nathan suggests that animal movement is a function of internal state (why), motion capacity (how), navigation capacity (when and where) and external factors (abiotic and biotic). In this formulation, the motion process and navigation process are both impacted by current location, internal state (i.e. physiological or neurological state affecting motivation and readiness to move) and external factors. The movement propagation process is the realized movement resulting from the motion process, which is optionally affected by the navigation process.

![Process](/img/process.png)

The result of this process is a lifetime movement track, which is observed by us. This track can be parsed into sub-units at various spatial and temporal scales: movement paths that represent particular phenomena such as feeding or migrating; and at even finer scales, movement steps which could correspond to a few steps and a stop. Our ability to successfully identify movement phases depends on our ability to sample an individual's movement (i.e. sampling frequency, duration and protocol).

![Path](/img/path.png)

This leads me to the first major challenge in the study of fish movement from acoustic telemetry arrays: limited sampling frequency and duration. Movement tracks from stationary receivers produce frequent and potentially large gaps in our knowledge of a fishes movement over time. These occur when a fish is moving or resting between receivers, or has died or emigrated outside of the receiver array.

Specialized statistical methods such as state-space models are required to separate the ecological state of interest from detection error. Hidden Markov Models are a class of state-space models useful for uncovering a finite number of states of interest (e.g., resident vs transitory states) with great potential for advancing the study of fish movement from acoustic telemetry.

Another challenge is incorporating motion capacity and navigation capacity in our models of fish movement. Typical studies of fish movement patterns are primarily interested relating the internal state (i.e., motivations for moving such as feeding or spawning) with external factors (e.g., water temperature, discharge). These fall under the 'optimality' paradigm discussed by Nathan and common in landscape ecology.

The utility of Nathan's framework is to force us to more comprehensively think about different aspects of fish movement and attempt to incorporate these into our models. For example, we can incorporate understanding of biomechanical constraints to fish movement (e.g. movement speed, movement in relation to water temperature). We can also incroporate aspects of our understanding of the cognitive or physiological aspects of navigation. These could either inform our interpretation of patterns or could inform how we parse movement tracks into phases within our models.
