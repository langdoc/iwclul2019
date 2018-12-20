library(tidyverse)

dir("~/github/unified-northern-alphabet-ocr/train_part_7/", pattern = "gt.txt", full.names = TRUE, recursive = TRUE) %>%
  map_df(~ {tibble(character = read_file(.x) %>% str_split(''),
                   file = .x)}) %>%
  unnest(character) %>%
  mutate(type = case_when(str_detect(character, "\\p{Uppercase_Letter}") ~ "upper",
                          str_detect(character, "\\p{Lowercase_Letter}") ~ "lower",
                          TRUE ~ "other")) %>%
  filter(! type == "other") %>%
  mutate(language = str_extract(file, "(sjd|mns|yrk|sel)")) %>%
  mutate(character_low = tolower(character)) %>%
  #  filter(language == "mns") %>%
  count(character_low, sort = TRUE) %>% View
filter(character == "ə̄")
count(type)

get_characters <- function(){
  dir("~/github/iwclul2018una/test/yrk/", pattern = "gt.txt", full.names = TRUE, recursive = TRUE) %>%
  map_df(~ {tibble(character = read_file(.x) %>% str_split(''),
                   file = .x)}) %>%
  unnest(character) %>%
  mutate(type = case_when(str_detect(character, "\\p{Uppercase_Letter}") ~ "upper",
                          str_detect(character, "\\p{Lowercase_Letter}") ~ "lower",
                          TRUE ~ "other")) %>%
  filter(! type == "other") %>%
  mutate(language = str_extract(file, "(sjd|mns|yrk|sel)")) %>%
  mutate(character = tolower(character)) %>%
  count(character, sort = TRUE) %>% View 
  filter(character == "") %>% pull(file)
  View
count(type)
}