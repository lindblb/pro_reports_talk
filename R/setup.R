

library(DBI)
library(glue)
library(here)
library(janitor)
library(kableExtra)
library(lubridate)
library(maps)
library(RSQLite)
library(scales)
library(sf)
library(tidyverse)



# Get dates ---------------------------------------------------------------



this_month <- lubridate::today() %>% lubridate::month()

this_year <-  lubridate::today() %>% lubridate::year() - 1



# Set up connection to db -------------------------------------------------


db <- DBI::dbConnect(RSQLite::SQLite(), dbname="database/prod.sqlite")



# Get data to map over ----------------------------------------------------

input_data <- DBI::dbReadTable(conn = db,
                               name = "financials") %>% 
  dplyr::select(branch) %>% 
  dplyr::distinct()


