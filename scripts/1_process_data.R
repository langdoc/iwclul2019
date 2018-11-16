library(tidyverse)
library(tidytext)

meta_part_1 <- tribble(~page, ~lang, ~orig_page,
                       1, "mns", 7,
                       2, "mns", 8,
                       3, "mns", 9,
                       4, "sel", 7,
                       5, "sel", 8,
                       6, "sel", 9,
                       7, "yrk", 7,
                       8, "yrk", 8,
                       9, "yrk", 9,
                       10, "sjd", 7,
                       11, "sjd", 8,
                       12, "sjd", 9) %>%
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
                       15, "yrk", 10,
                       16, "yrk", 11,
                       17, "yrk", 12,
                       18, "yrk", 13,
                       19, "yrk", 14,
                       20, "yrk", 15,
                       21, "yrk", 16,
                       22, "sjd", 10,
                       23, "sjd", 11,
                       24, "sjd", 12,
                       25, "sjd", 13,
                       26, "sjd", 14,
                       27, "sjd", 15,
                       28, "sjd", 16) %>%
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

meta_part_7 <- tribble(~page, ~lang, ~orig_page,
                       1, "evn", 54,
                       2, "evn", 55,
                       3, "evn", 56,
                       4, "evn", 57,
                       5, "evn", 58,
                       6, "evn", 59,
                       7, "evn", 56,
                       8, "evn", 57,
                       9, "evn", 58,
                       10, "evn", 59,
                       11, "evn", 56,
                       12, "evn", 57,
                       13, "evn", 58,
                       14, "evn", 59,
                       15, "evn", 56,
                       16, "evn", 57,
                       17, "evn", 58,
                       18, "evn", 59,
                       19, "evn", 60,
                       20, "evn", 61,
                       21, "evn", 62,
                       22, "evn", 63,
                       23, "evn", 64) %>%
  mutate(page = str_pad(page, width = "4", pad = "0"))


gt <- bind_rows(
  dir("../unified-northern-alphabet-ocr/train_part_1/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "multi") %>%
    left_join(meta_part_1),
  dir("../unified-northern-alphabet-ocr/train_part_2/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "multi") %>%
    left_join(meta_part_2),
  dir("../unified-northern-alphabet-ocr/train_part_3/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "sjd") %>%
    left_join(meta_part_3),
  dir("../unified-northern-alphabet-ocr/train_part_4/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "multi") %>%
    left_join(meta_part_4),
  dir("../unified-northern-alphabet-ocr/train_part_5/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "multi") %>%
    left_join(meta_part_5),
  dir("../unified-northern-alphabet-ocr/train_part_6/", 
      pattern = "gt.txt", 
      recursive = TRUE, 
      full.names = TRUE) %>%
    map_df(~ tibble(file = .x, line = read_file(.x))) %>%
    mutate(page = str_extract(file, "\\d{4}")) %>%
    mutate(set = "multi") %>%
    left_join(meta_part_6)#,
  # dir("../unified-northern-alphabet-ocr/train_part_7/", 
  #     pattern = "gt.txt", 
  #     recursive = TRUE, 
  #     full.names = TRUE) %>%
  #   map_df(~ tibble(file = .x, line = read_file(.x))) %>%
  #   mutate(page = str_extract(file, "\\d{4}")) %>%
  #   mutate(set = "evn") %>%
  #   left_join(meta_part_7)
) %>% 
  arrange(lang, orig_page) %>%
  group_by(set, lang) %>%
  mutate(id = 1:n()) %>%
  ungroup() %>%
  mutate(id_global = 1:n())

# gt %>% count(set, lang)
# gt %>% count(set)
# gt %>% filter(set == "multi") %>% count(lang)

system("rm train/mixed/*")

gt %>% 
  filter(set == "multi") %>%
  filter(id <= 200) %>%
  mutate(target_file = str_extract(file, "[^/]+$")) %>%
  mutate(image_source = str_replace(file, "gt.txt$", "bin.png")) %>%
  mutate(image_target = str_extract(image_source, "[^/]+$")) %>%
  split(.$id_global) %>% 
  walk(~ {file.copy(from = str_glue("{.x$file}"), to = str_glue("train/mixed/{.x$id_global}-{.x$set}-{.x$lang}-{.x$page}-{.x$target_file}"), overwrite = TRUE)
          file.copy(from = str_glue("{.x$image_source}"), to = str_glue("train/mixed/{.x$id_global}-{.x$set}-{.x$lang}-{.x$page}-{.x$image_target}"), overwrite = TRUE)})

system("rm test/*/*")

gt %>% 
  filter(set == "multi") %>%
  filter(id > 200) %>%
  filter(id <= 250) %>%
  mutate(target_file = str_extract(file, "[^/]+$")) %>%
  mutate(image_source = str_replace(file, "gt.txt$", "bin.png")) %>%
  mutate(image_target = str_extract(image_source, "[^/]+$")) %>%
  split(.$id_global) %>% 
  #  .[1:5] %>%
  walk(~ {file.copy(from = str_glue("{.x$file}"), to = str_glue("test/{.x$lang}/{.x$id_global}-{.x$set}-{.x$lang}-{.x$page}-{.x$target_file}"), overwrite = TRUE)
    file.copy(from = str_glue("{.x$image_source}"), to = str_glue("test/{.x$lang}/{.x$id_global}-{.x$set}-{.x$lang}-{.x$page}-{.x$image_target}"), overwrite = TRUE)})

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
#   filter(set == "sjd") %>%
#   filter(id > 800) %>%
#   mutate(target_file = str_extract(file, "[^/]+$")) %>%
#   mutate(image_source = str_replace(file, "gt.txt$", "bin.png")) %>%
#   mutate(image_target = str_extract(image_source, "[^/]+$")) %>%
#   View

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