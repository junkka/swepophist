library(dplyr)
library(tidyr)
library(stringr)
# xsl_url <- "http://www.scb.se/en_/Finding-statistics/Statistics-by-subject-area/Population/Population-composition/Population-statistics/Aktuell-Pong/25795/Yearly-statistics--The-whole-country/105505/"

raw <- read.csv("data-raw/data/scb_pop.csv")
colnames(raw) <- c(
  "year", "total_all", "total_women", "total_men",
  lapply(c(0:100), function(a){
    paste0("age", rep(a, 2), c("_women", "_men"))
  }) %>% unlist(),
  "agegroup0_women",
  "agegroup0_men",
  "agegroup20_women",
  "agegroup20_men",
  "agegroup65_women",
  "agegroup65_men"
  )
# for each 0:100 create c("age0_women", "age0_men")
trim_str <- function(a){
  unlist(plyr::llply(a, function(b){
    b %>% str_extract_all("[0-9]*") %>% unlist() %>% paste0(collapse = "") %>% as.integer()
  }))

}
age_pop <- raw %>%
  select(year, age0_women:age100_men) %>%
  gather(group, pop, -year) %>%
  separate(group, c("group", "gender"), sep = "_") %>%
  mutate(age = as.integer(str_extract(group, "[0-9]{1,3}$")),
    pop = trim_str(pop),
    span = 1,
    pop = ifelse(is.na(pop), 0, pop)
  ) %>%
  select(-group)

# save(age_pop, file = "data/age_pop.rda")

# add swe_pop_age before 1861
raw <- read.csv("data-raw/data/pop_age_1750_1967.csv")

make_span <- function(a){
  a <- str_replace(a, "age_", "")
  start <- as.integer(str_extract(a, "^[0-9]{1,2}"))
  stop <- as.integer(str_extract(a, "[0-9]{1,2}$"))
  x <- stop - start + 1
  ifelse(x < 5, 10, x)
}

swe_pop_age <- tbl_df(raw) %>% gather(age, n, -year) %>%
  filter(age != "total") %>%
  mutate(
    span = make_span(age),
    age = str_replace(age, "age_", ""),
    age = as.integer(str_extract(age, "^[0-9]{1,2}")),
    gender = "all"
  ) %>% rename(pop = n) %>%
  filter(year < 1861)

pop_age <- rbind(age_pop, swe_pop_age) %>% arrange(year) %>%
  as.data.frame()

save(pop_age, file = "data/pop_age.rda")
