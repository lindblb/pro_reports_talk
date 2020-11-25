


source(here::here("R/setup.R"))


# Iterator functions ------------------------------------------------------



create_reports <- function(...) {
  
  current <- tibble::tibble(...)

  loc <- here::here("R/rmarkdown/report_master.Rmd")
  
  
  rmarkdown::render(
    input = loc,
    output_file = paste0(current$branch, "_", this_year, "_", this_month ,".pdf"),
    output_dir = paste0("finished_reports"),
    intermediates_dir = "/finished_reports/tex",
    clean = T,
    params = list(branch = current$branch,
                  month = this_month,
                  year = this_year)
  )
  
  
}


maybe_create_reports <- purrr::possibly(.f = create_reports, otherwise = NULL)




# Main iterator -----------------------------------------------------------


input_data %>% 
  purrr::pwalk(maybe_create_reports)