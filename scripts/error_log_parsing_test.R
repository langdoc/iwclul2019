parse_error_log <- function(log_file){
  read_lines(log_file, skip = 4, n_max = 1) %>%
  map_df(~ tibble(test_name = str_extract(log_file, "(?<=logs/).+"),
         numbers = str_extract(.x, "[. \\d]+") %>% 
           str_remove("\\.$") %>% str_trim)) %>%
         separate(numbers, into = c("error_rate", "errors", "chars"), sep = " ", convert = TRUE)
}

parse_error_log("logs/mixedxsel")

dir("logs/", full.names = TRUE) %>%
  map_df(parse_error_log)
