# imr.R
library(assertthat)
library(stringr)
library(tidyr)
library(dplyr)

imr_raw <- read.csv("data-raw/data/imr_county_1811-1970.csv") %>% 
  mutate(county = c(1:25))
imr <- imr_raw %>% 
  gather(years, imr, -X, -county) %>%  
  mutate(
    from = as.integer(str_extract(years, "[0-9]{4}")),
    to   = as.integer(str_replace(str_extract(years, "\\.[0-9]{2,4}"), "\\.", "")),
    to   = ifelse(is.na(to), from, to),
    to   = ifelse(nchar(to) == 2, as.integer(paste0(substr(from, 1,2), to)), to) 
    ) %>% 
    select(-X, -years) %>% 
    filter(!is.na(imr))

assert_that(all(imr$from <= imr$to))

save(imr, file = "data/imr.rda")