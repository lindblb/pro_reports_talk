## code to prepare `fake` dataset goes here

library(charlatan)
library(DBI)
library(RSQLite)
library(tidyverse)




# Create db ---------------------------------------------------------------

db <- dbConnect(SQLite(), dbname="database/prod.sqlite")

# dbDisconnect(db)


# Create financials table -------------------------------------------------

dates <- c("2019-01", "2019-02", "2019-03", "2019-04", "2019-05", "2019-06", 
           "2019-07", "2019-08", "2019-09", "2019-10", "2019-11", "2019-12") %>% rep(3)
branches <- c(rep("fargo", 12), rep("belfield", 12), rep("kindred", 12))
  
financials <- tibble::tibble(
  branch = branches,
  date = dates,
  loans_leases = charlatan::ch_unif(n=36, min = 1000, max = 20000),
  debt_sec = charlatan::ch_unif(n=36, min = 5000, max = 40000),
  other_int_income = charlatan::ch_unif(n=36, min = 2000, max = 60000),
  deposits = charlatan::ch_unif(n=36, min = 20000, max = 100000),
  long_term_debt = charlatan::ch_unif(n=36, min = 10000, max = 40000),
  card_income = charlatan::ch_unif(n=36, min = 2000, max = 90000),
  svc_charges = charlatan::ch_unif(n=36, min = 10000, max = 60000),
  personnel = charlatan::ch_unif(n=36, min = 30000, max = 40000),
  occupancy = charlatan::ch_unif(n=36, min = 1000, max = 6000),
  marketing = charlatan::ch_unif(n=36, min = 800, max = 3000),
)

DBI::dbWriteTable(conn = db, name = "financials", value = financials, overwrite = T)


# Create customers table --------------------------------------------------

customers <- tibble::tibble(
  CIF = seq(1000, 1029, 1),
  branch = branches <- c(rep("fargo", 10), rep("belfield", 10), rep("kindred", 10)),
  cust_name = charlatan::ch_company(n = 30, locale = "en_US"),
  interest_income = charlatan::ch_unif(n=30, min = 2000, max = 90000),
  state = sample(c("north dakota", "minnesota", "wisconsin" , "south dakota", "montana", "iowa", "arkansas"),30,  replace = T)
)

DBI::dbWriteTable(conn = db, name = "customers", value = customers, overwrite = T)






# usethis::use_data(fake, overwrite = TRUE)





