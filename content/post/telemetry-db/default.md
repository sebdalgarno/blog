---
autoCollapseToc: true
categories: 
- database design
- acoustic telemetry
contentCopyright: MIT
date: "2021-01-15T00:00:00+08:00"
draft: true
lastmod: "2021-01-15T00:00:00+08:00"
mathjax: true
tags:
- postgresql
- rstats
- sql
- acoustic telemetry
- database
title: Designing a database for acoustic telemetry studies
weight: 10
---
# Overview
This is a series of posts that will aim to:  
1. outline a philosophy and structure for the ideal acoustic telemetry database   
1. justify this philosophy and structure within the context of a broader analysis pipeline 
1. demonstrate the SQL and R code to achieve this  
1. outline design of an R package to facilitate building the database

# Philosophy 

# Structure

# The analysis pipeline

These will all be explained in further detail. This first post will focus on the first two points.

The analysis pipeline:
punch raw data -> clean data for db -> insert data into db (via app) -> receive informative error messages -> repeat until successful -> PostgreSQL functions tidy data -> read tidied data into R for analysis

For a bit of context, I worked on a a number of multi-year acoustic telemetry studies for freshwater fish while working with [Poisson Consulting](https://poissonconsulting.ca). Our approach was very similar to the above. However, R came into the picture much sooner (i.e. around the clean stage) and remained there. We used R to check the data within the app (Shiny), R to tidy the data, etc. The approach I am proposing here removes R until the analysis stage and moves the preceding code into SQL functions within the database itself. Why?  

1. Moves processing time (from tidying) into the data insert stage, thus reducing time needed to read tidied output at the other end of the pipeline (e.g. by app)
1. Removes the need for Shiny (although Shiny may still be a useful option for a number of reasons) by simply providing tidied output tables from the db itself.
1. Removes potential error casued by translating data checking from R to SQL (i.e. if the db rejects then that is that...whereas if checking r objects and hoping you have enough checks that then the SQL insert will work)  
1. This bakes in the tidying code at the database design stage, thus removing the need to carry over (broken?) R code year to year.  
1. take advantage of PostGIS (faster spatial operations on db itself).  

Correct management of datetime and spatial data