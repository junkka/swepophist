# scb_swe_age
library(tidyr)
library(stringr)
library(dplyr)

raw <- read.csv("data-raw/data/pop_age_1750_1967.csv")

swe_pop_age <- tbl_df(raw) %>% gather(age, n, -year) %>% 
  mutate(age = as.factor(str_replace(age, "age_", "")))

save(swe_pop_age, file = "data/swe_pop_age.rda")
