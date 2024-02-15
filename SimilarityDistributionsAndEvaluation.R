## Clear Everything
rm(list=ls())

## Get the only package most people need
library(tidyverse)

## Themes
tema <- theme(
  axis.title.x = element_text(size = 14, family = "Times New Roman"),
  axis.title.y = element_text(size = 14, family = "Times New Roman"),
  axis.text.x = element_text(size = 12, color = "black", family = "Times New Roman"),
  axis.text.y = element_text(size = 12, color = "black", family = "Times New Roman"), 
  plot.title = element_text(size = 16, hjust = 0.5, family = "Times New Roman"),
  plot.subtitle = element_text(size = 10, hjust = 0.5, family = "Times New Roman"),
  text = element_text(family = "Times New Roman"), legend.position = "top",
  plot.background = element_blank()
) 

##=====================================================================================
#                                 Column Pairwise Density Distributions
##=====================================================================================

df <- read_csv("./Data/ColumnPairwiseSimilarity.csv")
df$StatusSemi <- ifelse(df$Status == "Published", "Filtered", "Kept")

ggplot(df, aes(x = Problem_Solution, fill = StatusSemi, color = StatusSemi)) +
  geom_density(aes(y = ..density..), adjust = 1.5, alpha = 0.7) + 
  theme_classic() +
  facet_wrap(~Challenge) +
  tema

##=====================================================================================
#                         Similarity to Problem Statement Density Distributions
##=====================================================================================

df <- read_csv("./Data/SimilarityToPS.csv")
df$StatusSemi <- ifelse(df$Status == "Published", "Filtered", "Kept")

ggplot(df, aes(x = Target, fill = StatusSemi, color = StatusSemi)) +
  geom_density(aes(y = ..density..), adjust = 1.5, alpha = 0.7) + 
  theme_classic() +
  facet_wrap(~Challenge) +
  tema

##=====================================================================================
#                                 Column Pairwise vs Evaluation (SemiFinal Round)
##=====================================================================================

df <- read_csv("./Data/ColumnPairwiseSimilarity.csv")
eval <- read_csv("./Data/2023Eval.csv")

df |>
  left_join(eval, by = "ID") -> df

#df[, colnames(eval)][is.na(df[, colnames(eval)])] <- 0

ggplot(data = df, aes(x = Problem_Solution, y = total, color = StatusSemi)) +
  geom_point() +
  geom_smooth(method = "lm", colour = "orange", se = FALSE) +
  facet_wrap(~Challenge) + tema


##=====================================================================================
#           Similarity to Problem Statement vs Evaluation (SemiFinal Round)
##=====================================================================================

df <- read_csv("./Data/SimilarityToPS.csv")
eval <- read_csv("./Data/2023Eval.csv")

df |>
  left_join(eval, by = "ID") -> df

#df[, colnames(eval)][is.na(df[, colnames(eval)])] <- 0

ggplot(data = df, aes(x = Problem, y = total, color = Status)) +
  geom_point() +
  geom_smooth(method = "lm", colour = "orange", se = FALSE) +
  facet_wrap(~Challenge) + tema
