# fert.R

library(stringr)
library(tidyr)
library(dplyr)

raw <- read.csv("data-raw/data/fert.csv", encoding = "utf8", stringsAsFactors = FALSE) %>% 
  select(-tfr)

pop_fert <- raw %>% gather(age, fert, age15.19:age45.49) %>% 
  mutate(
    context = factor(iconv(context, "utf8", "utf8")),
    fert = ifelse(context != "Sweden", fert/10, fert),
    start = as.integer(str_extract(year, "^[0-9]{4}")),
    end = as.integer(str_extract(year, "[0-9]{4}$")),
    age_g = as.integer(str_extract(str_replace(age, "age", ""), "^[0-9]{1,2}"))
  ) %>% select(context, county_code, start, end, age_g, fert)

save(pop_fert, file = "data/pop_fert.rda")
