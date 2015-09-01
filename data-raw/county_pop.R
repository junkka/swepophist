# county_pop.R

library(tidyr)
library(stringr)
library(dplyr)

raw <- read.csv("data-raw/data/county_pop.csv", stringsAsFactors = FALSE, encoding = "utf8")

d <- raw %>% gather(year, pop, X1749:X2010)

county_pop  <- d %>% 
  mutate(
    year = as.integer(str_replace(year, "^X", "")),
    name = iconv(name, "utf8", "utf8")
  ) %>% 
  filter(!is.na(pop))

save(county_pop, file = "data/county_pop.rda")
