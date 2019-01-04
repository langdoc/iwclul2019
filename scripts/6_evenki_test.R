library(tidyverse)
library(ggplot2)
library(tidytext)

run_model <- function(model, folder){
  system(str_glue("ocropus-rpred -q -Q 4 -m {model} '{folder}'"))
}

evaluate_model <- function(model, test_set){
  
  test_gt <- str_replace(test_set, "bin.png", "gt.txt")
  
  result <- system(str_glue("ocropus-econf -c 0 {test_gt}"), 
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

evenki_gt = "gt/evn/*.bin.png"

run_model(model = "models/mixed/mixed-00050000.pyrnn.gz", folder = evenki_gt)

score_mixed <- evenki_gt %>% 
  map_df(~ {evaluate_model(model = "mixed", test_set = .x)})

run_model(model = "models/sjd/sjd-00050000.pyrnn.gz", folder = evenki_gt)

score_sjd <- evenki_gt %>% 
  map_df(~ {evaluate_model(model = "sjd", test_set = .x)})

scores <- bind_rows(score_mixed, score_sjd)

scores
