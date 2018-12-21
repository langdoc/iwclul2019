library(tidyverse)
library(ggplot2)
library(tidytext)

# scores <- dir("evaluation/", full.names = TRUE, recursive = TRUE) %>%
#   map_df(~ {
#     read_tsv(.x, 
#          col_names = c("errors", "characters", "line")) %>%
#   mutate(lang = str_extract(line, "(mns|sel|sjd|yrk)")) %>%
#   mutate(epoch = str_extract(.x, "\\d{8}") %>% as.numeric()) %>%
#   mutate(score = errors / characters) %>%
#   mutate(experiment = str_extract(.x, "(mixed|sjd)"))
#   }
# )
# 
# scores %>% 
#   filter(experiment == "mixed") %>%
#   group_by(epoch, lang) %>%
#   summarise(error_mean = mean(score)) %>%
#   ggplot(data = ., aes(x = epoch, y = error_mean, color = lang)) +
#   geom_line()
# 
# scores %>% 
#   filter(experiment == "mixed") %>%
#   group_by(epoch) %>%
#   summarise(error_mean = mean(score)) %>%
#   ggplot(data = ., aes(x = epoch, y = error_mean)) +
#   geom_line()
# 
# scores %>% 
#   filter(experiment == "sjd") %>%
#   group_by(epoch) %>%
#   summarise(error_mean = mean(score)) %>%
#   arrange(error_mean)
# 
# scores %>% 
#   filter(experiment == "sjd") %>%
#   group_by(epoch) %>%
#   summarise(error_mean = mean(score)) %>%
#   ggplot(data = ., aes(x = epoch, y = error_mean)) +
#   geom_line()


evaluate_model <- function(model = "models/mixed/mixed-00020000.pyrnn.gz", test_set = "test/*/*.bin.png"){

  test_gt <- str_replace(test_set, "bin.png", "gt.txt")

  system(str_glue("/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -q -Q 4 -m {model} '{test_set}'"))
  result <- system(str_glue("/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-econf -c 0 {test_gt}"), 
                   intern = TRUE) %>%
    str_replace_all(" +", " ") %>%
    glue::glue_collapse(sep = " ") %>%
    map_df(~ {tibble(model = model,
           errors = str_extract(.x, "(?<=errors )\\d+"),
           percent = str_extract(.x, "(?<=err )[\\d.]+"),
           test = test_set)})
  result
}

tests <- c("test/mns/*.bin.png", "test/sel/*.bin.png", "test/sjd/*.bin.png", "test/yrk/*.bin.png")

scores <- bind_rows(tests %>% map_df(~ evaluate_model(model = "models/mixed/mixed-00020000.pyrnn.gz", test_set = .x)),
                    tests %>% map_df(~ evaluate_model(model = "models/sjd/sjd-00020000.pyrnn.gz", test_set = .x)))

scores %>% mutate(model_type = str_extract(model, "(sjd|mixed)")) %>%
  mutate(test = str_extract(test, "(mns|sjd|yrk|sel)")) %>%
  mutate(error_rate = as.double(percent)) %>%
  ggplot(data = ., aes(x = test, y = error_rate)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ model_type) + 
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)) +
  labs(x = "Test set",
       y = "Error rate (%)")

dir("test", pattern = "prob$", full.names = TRUE, recursive = TRUE) %>%
  map_df(~ {
    read_tsv(.x, col_names = c("char", "prob")) %>%
        mutate(lang = str_extract(.x, "(mns|sel|sjd|yrk)"))
               }
    ) %>%
  group_by(char) %>%
  summarise(error_mean = mean(prob)) %>%
  arrange(error_mean)


gt %>% group_by(page, lang, orig_page) %>%
  mutate(chars = nchar(line)) %>%
  summarise(page_chars = sum(chars)) %>%
  arrange(page_chars) %>% View

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

