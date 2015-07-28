# mfrt.R
library(stringr)
library(tidyr)
library(dplyr)

raw <- read.csv("data-raw/data/hofsten_mfrt.csv")

mfrt <- raw %>% gather(age, fert, X15_19:X45_59) %>% 
  filter(!is.na(fert)) %>% 
  mutate(age = str_replace(str_replace(age, "X", ""), "_", "-")) %>% 
  arrange(context, to, age)

tot <- mfrt %>% 
  filter(!age %in% c("15-19", "45-59")) %>% 
  group_by(from, to, context, county_code) %>% 
  summarise(fert = sum(fert/1000)*5) %>% 
  mutate(age = "total")

mfrt <- rbind(mfrt, tot)

update_encoding <- function(x) {
  Encoding(levels(x)) <- "UTF-8"
  levels(x) <- iconv(
    levels(x), 
    "UTF-8",
    "latin1" 
  )

  Encoding(levels(x)) <- "latin1"
  levels(x) <- iconv(
    levels(x), 
    "latin1", 
    "UTF-8"
  )
  return(x)
}

mfrt$context <- update_encoding(mfrt$context)

save(mfrt, file = "data/mfrt.rda")