suppressPackageStartupMessages(library(tidyverse))
library(tidytext)
library(xtable)

dir.create("train/")
dir.create("train/mixed")
dir.create("train/sjd")
dir.create("test")
dir.create("test/mns")
dir.create("test/sel")
dir.create("test/sjd")
dir.create("test/yrk")

meta_part_1 <- tribble(~page, ~lang, ~orig_page,
                       1, "mns", 7,
                       2, "mns", 8,
                       3, "mns", 9,
                       4, "sel", 7,
                       5, "sel", 8,
                       6, "sel", 9,
                       7, "sjd", 7,
                       8, "sjd", 8,
                       9, "sjd", 9,
                       10, "yrk", 7,
                       11, "yrk", 8,
                       12, "yrk", 9) %>%
  mutate(page = str_pad(page, width = "4", pad = "0"))

meta_part_2 <- tribble(~page, ~lang, ~orig_page,
                       1, "mns", 10,
                       2, "mns", 11,
                       3, "mns", 12,
                       4, "mns", 13,
                       5, "mns", 14,
                       6, "mns", 15,
                       7, "mns", 16,
                       8, "sel", 10,
                       9, "sel", 11,
                       10, "sel", 12,
                       11, "sel", 13,
                       12, "sel", 14,
                       13, "sel", 15,
                       14, "sel", 16,
                       15, "sjd", 10,
                       16, "sjd", 11,
                       17, "sjd", 12,
                       18, "sjd", 13,
                       19, "sjd", 14,
                       20, "sjd", 15,
                       21, "sjd", 16,
                       22, "yrk", 10,
                       23, "yrk", 11,
                       24, "yrk", 12,
                       25, "yrk", 13,
                       26, "yrk", 14,
                       27, "yrk", 15,
                       28, "yrk", 16) %>%
  mutate(page = str_pad(page, width = "4", pad = "0"))

meta_part_3 <- tibble(page = 1:34 %>%
                        str_pad(width = "4", pad = "0"),
                      lang = "sjd", orig_page = 17:50)

meta_part_4 <- tribble(~page, ~lang, ~orig_page,
                       1, "mns", 51,
                       2, "mns", 52,
                       3, "mns", 53,
                       4, "sel", 51,
                       5, "sel", 52,
                       6, "sel", 53,
                       7, "sjd", 51,
                       8, "sjd", 52,
                       9, "sjd", 53,
                       10, "yrk", 51,
                       11, "yrk", 52,
                       12, "yrk", 53) %>%
  mutate(page = str_pad(page, width = "4", pad = "0"))

meta_part_5 <- tribble(~page, ~lang, ~orig_page,
                       1, "sel", 54,
                       2, "sel", 55,
                       3, "sjd", 54,
                       4, "sjd", 55,
                       5, "yrk", 54,
                       6, "yrk", 55) %>%
  mutate(page = str_pad(page, width = "4", pad = "0"))

meta_part_6 <- tribble(~page, ~lang, ~orig_page,
                       1, "mns", 54,
                       2, "mns", 55,
                       3, "mns", 56,
                       4, "mns", 57,
                       5, "mns", 58,
                       6, "mns", 59,
                       7, "sel", 56,
                       8, "sel", 57,
                       9, "sel", 58,
                       10, "sel", 59,
                       11, "sjd", 56,
                       12, "sjd", 57,
                       13, "sjd", 58,
                       14, "sjd", 59,
                       15, "yrk", 56,
                       16, "yrk", 57,
                       17, "yrk", 58,
                       18, "yrk", 59) %>%
  mutate(page = str_pad(page, width = "4", pad = "0"))

meta_part_8 <- tribble(~page, ~lang, ~orig_page,
                       1, "mns", 60,
                       2, "sel", 60,
                       3, "sjd", 60,
                       4, "yrk", 60) %>%
  mutate(page = str_pad(page, width = "4", pad = "0"))

# meta_part_7 <- tribble(~page, ~lang, ~orig_page,
#                        1, "evn", 54,
#                        2, "evn", 55,
#                        3, "evn", 56,
#                        4, "evn", 57,
#                        5, "evn", 58,
#                        6, "evn", 59,
#                        7, "evn", 56,
#                        8, "evn", 57,
#                        9, "evn", 58,
#                        10, "evn", 59,
#                        11, "evn", 56,
#                        12, "evn", 57,
#                        13, "evn", 58,
#                        14, "evn", 59,
#                        15, "evn", 56,
#                        16, "evn", 57,
#                        17, "evn", 58,
#                        18, "evn", 59,
#                        19, "evn", 60,
#                        20, "evn", 61,
#                        21, "evn", 62,
#                        22, "evn", 63,
#                        23, "evn", 64) %>%
#   mutate(page = str_pad(page, width = "4", pad = "0"))


gt <- bind_rows(
  dir("./data/unified-northern-alphabet-ocr/train_part_1/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "mixed") %>%
    left_join(meta_part_1, by = "page"),
  dir("./data/unified-northern-alphabet-ocr/train_part_2/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "mixed") %>%
    left_join(meta_part_2, by = "page"),
  dir("./data/unified-northern-alphabet-ocr/train_part_3/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "sjd") %>%
    left_join(meta_part_3, by = "page"),
  dir("./data/unified-northern-alphabet-ocr/train_part_4/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "mixed") %>%
    left_join(meta_part_4, by = "page"),
  dir("./data/unified-northern-alphabet-ocr/train_part_5/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "mixed") %>%
    left_join(meta_part_5, by = "page"),
  dir("./data/unified-northern-alphabet-ocr/train_part_6/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "mixed") %>%
    left_join(meta_part_6, by = "page"),
  dir("./data/unified-northern-alphabet-ocr/train_part_8/",
      pattern = "gt.txt",
      recursive = TRUE,
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "mixed") %>%
    left_join(meta_part_8, by = "page")
) %>% 
  arrange(lang, orig_page) %>%
  mutate(id_global = 1:n()) %>%
  mutate(new_filename = str_extract(file, "train_part_.+")) %>%
  mutate(new_filename = str_replace_all(new_filename, "[/]+", "-"))

# gt %>% mutate(file = str_remove(file, "./data/unified-northern-alphabet-ocr/")) %>%
#   select(-line, -set, -id_global) %>%
#   rename(language = lang) %>%
#   write_csv("../unified-northern-alphabet-ocr/meta_pages.csv")

# gt %>% count(set, lang)
# gt %>% count(set)
# gt %>% filter(set == "mixed") %>% filter(lang == "sjd") %>% View
# gt %>% filter(lang == "sjd") %>% View

# read_csv("data/unified-northern-alphabet-ocr/meta_pages.csv")

title_ids <- read_csv("./data/unified-northern-alphabet-ocr/meta_extra.csv", 
                      col_names = c("file", "type"), col_types = "cc") %>%
  filter(type == "title")

# gt %>% mutate(big_text = toupper(line)) %>% filter(big_text == line) %>% View

gt <- gt %>% mutate(text_id = str_remove(file, "./data/unified-northern-alphabet-ocr/")) %>%
  mutate(text_id = str_remove(text_id, ".gt.txt")) %>%
  mutate(text_id = str_replace(text_id, "//", "/")) %>%
#  select(text_id) %>%
  filter(! text_id %in% title_ids$file) %>%
  select(-text_id)

gt <- gt %>% group_by(set, lang) %>%
  mutate(id = 1:n()) %>%
  ungroup()

gt_train_mixed <- gt %>% 
  filter(set == "mixed") %>%
  filter(id <= 200) %>%
  mutate(target_file = str_extract(file, "[^/]+$")) %>%
  mutate(image_source = str_replace(file, "gt.txt$", "bin.png")) %>%
  mutate(image_target = str_extract(image_source, "[^/]+$"))

gt_train_mixed %>% count(lang) %>% xtable(caption = "Train set sizes per language", type = "latex")

gt_train_mixed %>%
  split(.$id_global) %>% 
  walk(~ {file.copy(from = str_glue("{.x$file}"), to = str_glue("train/mixed/{.x$new_filename}"), overwrite = TRUE)
          file.copy(from = str_glue("{.x$image_source}"), to = str_glue("train/mixed/{.x$new_filename}"), overwrite = TRUE)})
  # walk(~ {file.copy(from = str_glue("{.x$file}"), to = str_glue("train/mixed/{.x$id_global}-{.x$set}-{.x$lang}-{.x$page}-{.x$target_file}"), overwrite = TRUE)
  #         file.copy(from = str_glue("{.x$image_source}"), to = str_glue("train/mixed/{.x$id_global}-{.x$set}-{.x$lang}-{.x$page}-{.x$image_target}"), overwrite = TRUE)})

gt_train_sjd <- bind_rows(gt_train_mixed %>%
  filter(lang == "sjd"),
  gt %>% filter(set == "sjd" & id <= 600)) %>%
  mutate(target_file = str_extract(file, "[^/]+$")) %>%
  mutate(image_source = str_replace(file, "gt.txt$", "bin.png")) %>%
  mutate(image_target = str_extract(image_source, "[^/]+$"))

gt_train_sjd %>% count(lang) %>% xtable(caption = "Train set sizes for sjd test", type = "latex")
  
gt_train_sjd %>%
  split(.$id_global) %>% 
  walk(~ {file.copy(from = str_glue("{.x$file}"), to = str_glue("train/sjd/{.x$new_filename}"), overwrite = TRUE)
    file.copy(from = str_glue("{.x$image_source}"), to = str_glue("train/sjd/{.x$new_filename}"), overwrite = TRUE)})

gt_test <- gt %>% 
  filter(set == "mixed") %>%
  filter(id > 200) %>%
  filter(id <= 300) %>%
  mutate(target_file = str_extract(file, "[^/]+$")) %>%
  mutate(image_source = str_replace(file, "gt.txt$", "bin.png")) %>%
  mutate(image_target = str_extract(image_source, "[^/]+$"))

gt_test %>% count(lang) %>% xtable(caption = "Test set sizes", type = "latex")

gt_test %>%
  split(.$id_global) %>% 
  walk(~ {file.copy(from = str_glue("{.x$file}"), to = str_glue("test/{.x$new_filename}"), overwrite = TRUE)
    file.copy(from = str_glue("{.x$image_source}"), to = str_glue("test/{.x$new_filename}"), overwrite = TRUE)})

gt %>% 
  group_by(orig_page, lang) %>% 
  summarise(lines_per_page = n()) %>% 
  ungroup %>% 
  summarise(average = mean(lines_per_page),
            maximum = max(lines_per_page),
            minimum = min(lines_per_page))

# gt_sjd_incr <- dir("train/sjd/", pattern = "png", full.names = TRUE) %>%
#   tibble(filename = .) %>%
#   mutate(page_group = rep(c(1:40), 20)) %>%
#   mutate(page_group_padded = str_pad(page_group, pad = "0", width = 2)) %>%
#   arrange(page_group)
# 
# slicing_window <- function(window){
#       
#   training_set <- gt_sjd_incr %>% 
#         filter(page_group <= window) %>% 
#         select(filename)
#       
#   filename = str_glue("training_lists/sjd-train-{str_pad(window, pad = '0', width = 2)}.txt")
#   write_delim(x = training_set, path = filename, col_names = FALSE)
# 
# }
# 
# 1:40 %>% walk(slicing_window)

# test_files <- gt %>% 
#   filter(set == "multi") %>%
#   filter(id > 200) %>%
#   filter(id <= 250) %>%
#   mutate(target_file = str_extract(file, "[^/]+$")) %>%
#   mutate(image_source = str_replace(file, "gt.txt$", "bin.png")) %>%
#   mutate(image_target = str_extract(image_source, "[^/]+$")) %>%
#   pull(file)
# 
# gt %>%
#   filter(! file %in% test_files) %>%
# #  filter(id <= 800) %>%
#   mutate(target_file = str_extract(file, "[^/]+$")) %>%
#   mutate(image_source = str_replace(file, "gt.txt$", "bin.png")) %>%
#   mutate(image_target = str_extract(image_source, "[^/]+$")) %>%
#   split(.$id_global) %>% 
#   walk(~ {file.copy(from = str_glue("{.x$file}"), to = str_glue("train/hybrid/{.x$id_global}-{.x$set}-{.x$lang}-{.x$page}-{.x$target_file}"), overwrite = TRUE)
#     file.copy(from = str_glue("{.x$image_source}"), to = str_glue("train/hybrid/{.x$id_global}-{.x$set}-{.x$lang}-{.x$page}-{.x$image_target}"), overwrite = TRUE)})

# ocropus-rtrain -c ./train/hybrid/*gt.txt -o models/hybrid/una-03-279620 -d 20 ./train/hybrid/*png


# gt %>% 
#   filter(set == "multi") %>%
#   filter(id > 250) %>%
#   count(lang)
#   
# 
# gt %>% filter(set == "multi") %>%
#   group_by(lang) %>%
#   slice(1:200)
# 
# gt %>% unnest_tokens(output = "token", line) %>%
#   count(set, lang) 
# 
# gt %>% count(set, lang)

gt %>%
  # group_by(lang) %>%
  mutate(character = str_split(line, '')) %>%
  unnest(character) %>%
  mutate(type = case_when(str_detect(character, "\\p{Uppercase_Letter}") ~ "upper",
                          str_detect(character, "\\p{Lowercase_Letter}") ~ "lower",
                          TRUE ~ "other")) %>%
  filter(! type == "other") %>%
  mutate(character = tolower(character)) %>%
  # filter(character == "е") %>% pull(file)
  count(character, sort = TRUE)
  