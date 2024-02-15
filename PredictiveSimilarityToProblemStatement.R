rm(list=ls())

library(tidyverse)

df <- read_csv("./Data/SimilarityToPS.csv")

df$StatusSemi <- ifelse(df$Status == "Published", 0, 1)

df$StatusFin <- ifelse(df$Status == "Finalist", 0, 1)
  
  
df |>  filter(StatusSemi == 1) -> d

summary(glm(StatusSemi ~ Problem + Solution, df, family = "binomial"))
summary(glm(StatusFin ~ Problem + Solution, d, family = "binomial"))
