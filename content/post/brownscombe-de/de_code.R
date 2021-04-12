rm(list = ls())
library(tibble)
library(ggplot2)
library(purrr)
library(dplyr)

# simulate data
nrec <- 12
set.seed(99)

rec <- data.frame(receiver = paste("receiver", 1:nrec),
                  depth = runif(nrec, 5, 20),
                  sentinel = c(TRUE, FALSE))
rec

sentinels <- rec$receiver[rec$sentinel]

dr <- map_df(sentinels, function(x){
  df <- rec[rec$receiver == x,]
  
  distance <- seq(0, 500, 60)
  b0 <- logit(0.99)
  bDist <- -0.027   
  bDepth <- 0.2
  z <- b0 + bDist * distance + bDepth * df$depth 
  pr <- ilogit(z)
  
  nsample <- 50
  success <- rbinom(rep(1, length(pr)), nsample, pr)
  failure <- nsample - success
  de <- success/nsample
  
  dr <- tibble(receiver = x,
               depth = df$depth,
               distance = distance,
               success  = success,
               failure = failure,
               de = de)
})

ggplot(data = dr) +
  geom_point(aes(x = distance, y = de*100, color = depth)) +
  facet_wrap(~receiver) + 
  labs(x = "Distance from Receiver (m)", y = "Detection Efficiency (%)")


models <- map(sentinels, function(x){
  dat <- dr[dr$receiver == x,]
  glm(cbind(success, failure) ~ distance, data = dat, family = "binomial")
}) %>% set_names(sentinels)

distvals <- seq(0, 600, 1)

calc_distance_at_de <- function(model, value) {
  find_int <- function(model, value) {
    function(x){
      predict(model, data.frame(distance = x), type = "response") - value
    }
  }
  uniroot(find_int(model, value), range(dr$distance))$root
}

preds <- map_df(sentinels, function(x){
  predvals <- predict(models[[x]], list(distance = distvals), type = "response")
  midpoint <- calc_distance_at_de(models[[x]], 0.5)
  mr <- calc_distance_at_de(models[[x]], 0.05)
  data.frame(receiver = x,
             distance = distvals,
             predvals = predvals,
             midpoint = midpoint,
             mr = mr)
})

ggplot(data = dr) +
  geom_point(aes(x = distance, y = de*100, color = depth)) +
  geom_line(data = preds, aes(x = distance, y = predvals*100), colour="black") +
  geom_point(data = preds, aes(x = midpoint, y = 50), color = "red", size = 2) +
  geom_point(data = preds, aes(x = mr, y = 5), color = "red", size = 2) +
  facet_wrap(~receiver) + 
  labs(x = "Distance from Receiver (m)", y = "Detection Efficiency (%)")

# simulate seasonal variation in ref tag
de_ref <- map_df(sentinels, function(x){
  df <- rec[rec$receiver == x,]
  
  day <- 1:365
  b0 <- rnorm(1, logit(0.5), 0.2)
  bDay <- 0.0002 
  bDepth <- 0.005
  z <- b0 + bDay * day  + bDepth * df$depth
  pr <- ilogit(z)
  
  # expect 11 detections/hour
  nsample <- 11*24 
  success <- rbinom(rep(1, length(pr)), nsample, pr)
  failure <- nsample - success
  de <- success/nsample
  de
  
  dr <- tibble(receiver = df$receiver,
               day = day,
               depth = df$depth,
               success  = success,
               failure = failure,
               DE = de)
})

ggplot(data = de_ref) +
  geom_point(aes(x = day, y = DE*100, color = depth)) +
  facet_wrap(~receiver) + 
  labs(x = "Day", y = "Detection Efficiency (%)")

# calculate DEv and DEvc - the difference between detection efficiency (DE) for each hour and the overall mean DE at each station:
de_ref <- de_ref %>% 
  group_by(receiver) %>% 
  mutate(DEmean = mean(DE)) %>%
  ungroup() %>%
  mutate(DEv = DE - DEmean,
         DEvc = if_else(DE - DEmean < 0, 
                        (DE-DEmean/DEmean)*.5,
                        ((DE-DEmean)/(1 - DEmean))*.5)
         )
         

mr <- preds %>%
  group_by(receiver) %>%
  summarize(MR = first(mr)) %>%
  ungroup()

drc <- de_ref %>%
  left_join(mr, "receiver") %>%
  mutate(DRc = MR + MR*(DEvc/100))

# calculate DEvc - scale DE to +/-50% based on mean DE across receivers
de_ref$DEvc <- ifelse(de_ref$DE-de_ref$DEmean<0, ((de_ref$DE-de_ref$DEmean)/de_ref$DEmean)*.5,
                       ((de_ref$DE-de_ref$DEmean)/(1-de_ref$DEmean))*.5)

ggplot(data = de_ref) +
  geom_point(aes(x = day, y = DEv*100, color = depth)) +
  facet_wrap(~receiver) + 
  labs(x = "Day", y = "Detection Efficiency (%)")


