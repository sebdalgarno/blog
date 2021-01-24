---
title: What is a statistical model
author: Seb
date: '2021-01-19'
slug: []
categories: []
tags:
  - bayesian statistics
  - maximum likelihood
lastmod: '2021-01-19T16:40:49-08:00'
draft: yes
keywords: []
description: ''
comment: no
toc: no
autoCollapseToc: no
postMetaInFooter: no
hiddenFromHomePage: no
contentCopyright: no
reward: no
mathjax: no
mathjaxEnableSingleDollar: no
mathjaxEnableAutoNumber: no
hideHeaderAndFooter: no
flowchartDiagrams:
  enable: no
  options: ''
sequenceDiagrams:
  enable: no
  options: ''
---

I think it is useful to take a step back and think about big-picture questions relating to statistical models. 

# What are statistical models
Very (very) broadly, statistical models use math to solve problems. But what distinguishes them from mere calculations or equations? For example Let's say you bought a house. Based on the price paid, mortgage period and interest rates, you ask the bank to tell you how much you will pay this year. They run some calculations and give you the answer. What is the difference between this and a statistical model?

The difference is that statistical models account for uncertainty. 
Statistical models describe uncertainty - that's what makes them different from calculations/equations.

# Why do we use them?
Fundamentally, we use statistical models to make decisions from uncertainty. More practically, we use statistical models to describe a relationship or process, and predict what can happen in the future (or in unsampled space) or in the past (or in the sampled space). Do we 

- to make decisions from uncertainty  

practically:  

- predicting what can happen in the future  
- state of things in the past
- describe a process/relationship
- are you modelling for job of getting predictive function or do you want to understand the system?  

Scientific statistical models - our parameters mean something - we want to understand process (as opposed to extreme versions of machine learning models that are purely predictive)

# How do they work?
Fundamental concept in statistical model is maximum likelihood.
If this model is true - what is probability that it would produce these data.
Let's say you have a model with set number of parameters. Each parameter coudl take a set of possible continuous values. Maximum likelihood is process of determining parameter values that are most likely to have given rise to the data.

Bayesian models are essentiallly ML (likelihood-based) but with prior information. Multiply posteriors by priors.  With Bayesian it is possible that you dont think the most likely model is true because yo already know something about the system. 

