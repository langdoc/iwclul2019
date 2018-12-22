library(tidyverse)
library(ggplot2)

errors <- read_lines("evaluation/incr/incr_log") %>%
  .[str_detect(., "(loading object|err )")] %>%
  glue::glue_collapse() %>%
  str_split("# loading ") %>%
  map_df(~ {tibble(model = str_extract(.x, "(?<=sjd-)\\d\\d"),
                   error_rate = str_extract(.x, "\\d\\d?\\.\\d+"))}) %>%
  filter(!is.na(model)) %>%
  mutate(error_rate = as.double(error_rate))

best_score <- errors %>% filter(error_rate == min(error_rate))

score_incr_plot <- ggplot(data = errors, aes(x = model, y = error_rate, group = 1)) +
  geom_line() +
  geom_point() +
  geom_point(data = best_score, colour="red", size = 2) +  # this adds a red point
  geom_text(data = best_score, label = "", hjust=-.1) +
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)) +
  # scale_y_continuous(labels = scales::percent) +
  labs(x = "Number of training pages",
       y = "Error rate (%)")

dir.create("plots")

ggsave(filename = "plots/figure_4.png", plot = score_incr_plot)

str_glue("Test scores for Kildin Saami OCR model. Best score with error rate of {best_score$error_rate}\\%  marked with red")
