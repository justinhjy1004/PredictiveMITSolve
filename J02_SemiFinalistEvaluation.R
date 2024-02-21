## Clear Everything
rm(list=ls())

## Load packages
library(readxl)
library(tidyverse)

## Relevant Columns
columns <- c("solution_id", "Alignment", "Potential for Impact", "Feasibility", "Innovative Approach", "Inclusive Human-Centered Design")

## Read individual Excel files 
## Specifically for Semifinalists 
semi <- read_excel("./Data/2023_Evaluation/Climate Adaptation.xlsx", sheet = "Semifinalist Selection")[,columns]
semi1 <- read_excel("./Data/2023_Evaluation/Financial Inclusion.xlsx", sheet = "Semifinalist Selection")[,columns]
semi2 <- read_excel("./Data/2023_Evaluation/Health in Fragile Contexts.xlsx", sheet = "Semifinalist Selection")[,columns]
semi3 <- read_excel("./Data/2023_Evaluation/Learning for Civic Action.xlsx", sheet = "Semifinalist Selection")[,columns]

df <- rbind(semi, semi1, semi2, semi3)

## Rename Columns
renamed_col <- c("ID", "alignment", "impact", "feasibility", "innovation", "inclusivity")
colnames(df) <- renamed_col

## Get averages of ratings
df |>
  group_by(ID) |>
  summarize_all(mean) -> df

## Calculate total scores
df$total <- rowSums(df[,c("alignment", "impact", "feasibility", "innovation", "inclusivity")])

write.csv(df, "./Data/2023Eval.csv", row.names = F)
