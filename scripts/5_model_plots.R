library(tidyverse)
library(ggplot2)
library(tidytext)

scores <- dir("evaluation/", full.names = TRUE, recursive = TRUE) %>%
  map_df(~ {
    read_tsv(.x, 
         col_names = c("errors", "characters", "line")) %>%
  mutate(lang = str_extract(line, "(mns|sel|sjd|yrk)")) %>%
  mutate(epoch = str_extract(.x, "\\d{8}") %>% as.numeric()) %>%
  mutate(score = errors / characters) %>%
  mutate(experiment = str_extract(.x, "(mixed|sjd)"))
  }
)

scores %>% 
  filter(experiment == "mixed") %>%
  group_by(epoch, lang) %>%
  summarise(error_mean = mean(score)) %>%
  ggplot(data = ., aes(x = epoch, y = error_mean, color = lang)) +
  geom_line()

scores %>% 
  filter(experiment == "mixed") %>%
  group_by(epoch) %>%
  summarise(error_mean = mean(score)) %>%
  ggplot(data = ., aes(x = epoch, y = error_mean)) +
  geom_line()

scores %>% 
  filter(experiment == "sjd") %>%
  group_by(epoch) %>%
  summarise(error_mean = mean(score)) %>%
  arrange(error_mean)

scores %>% 
  filter(experiment == "sjd") %>%
  group_by(epoch) %>%
  summarise(error_mean = mean(score)) %>%
  ggplot(data = ., aes(x = epoch, y = error_mean)) +
  geom_line()
  

dir("test", pattern = "prob$", full.names = TRUE) %>%
  map_df(~ {
    read_tsv(.x, col_names = c("char", "prob")) %>%
        mutate(lang = str_extract(.x, "(mns|sel|sjd|yrk)"))
               }
    ) %>%
  group_by(char) %>%
  summarise(error_mean = mean(prob)) %>%
  arrange(error_mean)


training_corpus <- dir("train", pattern = "gt.txt$", full.names = TRUE) %>%
  map_df(~ {tibble(line = read_file(.x),
                   file = .x)})

training_corpus %>%
  unnest_tokens(output = "chars", 
                input = line, 
                token = "regex", 
                pattern = "|", 
                to_lower = FALSE) %>%
  mutate(lang = str_extract(file, "(mns|sel|sjd|yrk)")) %>%
  group_by(lang) %>%
  count(chars, sort = TRUE)  %>% View

