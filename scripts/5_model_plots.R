library(tidyverse)
library(ggplot2)
library(tidytext)

run_model <- function(model = "models/mixed/mixed-00020000.pyrnn.gz", folder = "test/*/*.bin.png"){
  system(str_glue("/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -q -Q 4 -m {model} '{folder}'"))
}

evaluate_model <- function(model = "mixed", test_set = "test/*/*.bin.png"){

  test_gt <- str_replace(test_set, "bin.png", "gt.txt")

  result <- system(str_glue("/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-econf -c 0 {test_gt}"), 
                   intern = TRUE) %>%
    str_replace_all(" +", " ") %>%
    glue::glue_collapse(sep = " ") %>%
    map_df(~ {tibble(model = model,
           errors = str_extract(.x, "(?<=errors )\\d+"),
           characters = str_extract(.x, "(?<=total )\\d+"),
           percent = str_extract(.x, "(?<=err )[\\d.]+"),
           test = test_set)})
  result
}

tests <- c("test/mns/*.bin.png", "test/sel/*.bin.png", "test/sjd/*.bin.png", "test/yrk/*.bin.png")

run_model(model = "models/mixed/mixed-00050000.pyrnn.gz", folder = "test/*/*.bin.png")

score_mixed <- tests %>% 
  map_df(~ {evaluate_model(model = "mixed", test_set = .x)})

run_model(model = "models/sjd/sjd-00050000.pyrnn.gz", folder = "test/*/*.bin.png")

score_sjd <- tests %>% 
  map_df(~ {evaluate_model(model = "sjd", test_set = .x)})

scores <- bind_rows(score_mixed, score_sjd)

scores %>% mutate(test = str_extract(test, "(mns|sjd|yrk|sel)")) %>%
  select(model, test, errors, characters, percent) %>%
  knitr::kable(format = "latex")

score_plot <- scores %>% mutate(model_type = str_extract(model, "(sjd|mixed)")) %>%
  mutate(test = str_extract(test, "(mns|sjd|yrk|sel)")) %>%
  mutate(error_rate = as.double(percent)) %>%
  ggplot(data = ., aes(x = test, y = error_rate)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ model_type) + 
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)) +
  labs(x = "Test set",
       y = "Error rate (%)")

ggsave(filename = "plots/figure_5.png", plot = score_plot)

