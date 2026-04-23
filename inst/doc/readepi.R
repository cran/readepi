## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk[["set"]](collapse = TRUE, comment = "#>", eval = FALSE,
                           fig.width = 7L, fig.height = 7L, message = FALSE,
                           fig.align = "center", warning = FALSE, dpi = 300L)

## ----setup, eval=TRUE---------------------------------------------------------
# Load readepi
library(readepi)

## ----rdbms-login, eval=FALSE--------------------------------------------------
# # CONNECT TO THE TEST MYSQL SERVER
# rdbms_login <- login(
#   type = "mysql",
#   from = "mysql-rfam-public.ebi.ac.uk",
#   user_name = "rfamro",
#   password = "",
#   driver_name = "",
#   db_name = "Rfam",
#   port = 4497
# )

## ----display-tables, eval=FALSE-----------------------------------------------
# # DISPLAY THE LIST OF TABLES FROM A DATABASE OF INTEREST
# tables <- show_tables(login = rdbms_login)
# head(tables)

## ----rdbms-query, eval=FALSE--------------------------------------------------
# # READING ALL FIELDS AND ALL RECORDS FROM ONE TABLE (`author`) USING AN SQL
# # QUERY
# dat <- read_rdbms(
#   login = rdbms_login,
#   query = "select * from author"
# )

## ----rdbms-data, eval=FALSE---------------------------------------------------
# # READING ALL FIELDS AND ALL RECORDS FROM ONE TABLE (`author`) WHERE QUERY
# # PARAMETERS ARE SPECIFIED AS A LIST
# dat <- read_rdbms(
#   login = rdbms_login,
#   query = list(table = "author", fields = NULL, filter = NULL)
# )

## ----rdbms-filter, eval=FALSE-------------------------------------------------
# # SELECT FEW COLUMNS FROM ONE TABLE AND LEFT JOIN WITH ANOTHER TABLE
# dat <- read_rdbms(
#     login = rdbms_login,
#     query = "select author.author_id, author.name,
#   family_author.author_id from author left join family_author on
#   author.author_id = family_author.author_id"
# )

## ----pak-dat, echo=FALSE, eval=TRUE-------------------------------------------
# LOAD THE DATA OBTAINED FROM THE COMMAND ABOVE
dat <- readRDS(
  system.file("extdata", "server_data.RDS", package = "readepi")
)

## ----dispaly-data, echo=FALSE, eval=TRUE--------------------------------------
dat |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "200px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

## ----dhis2-login, eval=identical(Sys.getenv("NOT_CRAN"), "true")--------------
# # CONNECT TO A DHIS2 INSTANCE
# dhis2_login <- login(
#   type = "dhis2",
#   from = "https://play.im.dhis2.org/stable-2-41-8",
#   user_name = "admin",
#   password = "district"
# )

## ----org-units, eval=identical(Sys.getenv("NOT_CRAN"), "true")----------------
# # GET THE LIST OF ALL ORGANISATION UNITS IN AN HIERARCHICAL ORDER
# org_units <- get_organisation_units(login = dhis2_login)

## ----display-org-units, echo=FALSE, eval=identical(Sys.getenv("NOT_CRAN"), "true")----
# org_units |>
#   kableExtra::kbl() |>
#   kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
#   kableExtra::scroll_box(height = "200px", width = "100%",
#                          box_css = "border: 1px solid #ddd; padding: 5px; ",
#                          extra_css = NULL,
#                          fixed_thead = TRUE)

## ----dhis2-programs, eval=identical(Sys.getenv("NOT_CRAN"), "true")-----------
# # GET THE LIST OF ALL PROGRAMS
# programs <- get_programs(login = dhis2_login)

## ----display-programs, echo=FALSE, eval=identical(Sys.getenv("NOT_CRAN"), "true")----
# programs |>
#   kableExtra::kbl() |>
#   kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
#   kableExtra::scroll_box(height = "200px", width = "100%",
#                          box_css = "border: 1px solid #ddd; padding: 5px; ",
#                          extra_css = NULL,
#                          fixed_thead = TRUE)

## ----dhis2-elements, eval=identical(Sys.getenv("NOT_CRAN"), "true")-----------
# # GET THE LIST OF ALL DATA ELEMENTS
# data_elements <- get_data_elements(login = dhis2_login)

## ----display-elements, echo=FALSE, eval=identical(Sys.getenv("NOT_CRAN"), "true")----
# data_elements |>
#   kableExtra::kbl() |>
#   kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
#   kableExtra::scroll_box(height = "200px", width = "100%",
#                          box_css = "border: 1px solid #ddd; padding: 5px; ",
#                          extra_css = NULL,
#                          fixed_thead = TRUE)

## ----dhis2-stages, eval=identical(Sys.getenv("NOT_CRAN"), "true")-------------
# # GET THE LIST OF ALL PROGRAM STAGES FOR A GIVEN PROGRAM ID
# program_stages <- get_program_stages(
#   login = dhis2_login,
#   program = "IpHINAT79UW",
#   programs = programs
# )

## ----display-stages, echo=FALSE, eval=identical(Sys.getenv("NOT_CRAN"), "true")----
# program_stages |>
#   kableExtra::kbl() |>
#   kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
#   kableExtra::scroll_box(height = "200px", width = "100%",
#                          box_css = "border: 1px solid #ddd; padding: 5px; ",
#                          extra_css = NULL,
#                          fixed_thead = TRUE)

## ----target-units, eval=identical(Sys.getenv("NOT_CRAN"), "true")-------------
# # GET THE LIST OF ORGANISATION UNITS RUNNING THE SPECIFIED PROGRAM
# target_org_units <- get_program_org_units(
#     login = dhis2_login,
#     program = "IpHINAT79UW",
#     org_units = org_units
#   )

## ----display-target-units, echo=FALSE, eval=identical(Sys.getenv("NOT_CRAN"), "true")----
# target_org_units |>
#   kableExtra::kbl() |>
#   kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
#   kableExtra::scroll_box(height = "200px", width = "100%",
#                          box_css = "border: 1px solid #ddd; padding: 5px; ",
#                          extra_css = NULL,
#                          fixed_thead = TRUE)

## ----org-codes, eval=identical(Sys.getenv("NOT_CRAN"), "true")----------------
# # IMPORT DATA FROM DHIS2 FOR THE SPECIFIED ORGANISATION UNIT AND PROGRAM IDs
# data <- read_dhis2(
#   login = dhis2_login,
#   org_unit = "XjpmsLNjyrz",
#   program = "IpHINAT79UW"
# )

## ----display-codes, echo=FALSE, eval=identical(Sys.getenv("NOT_CRAN"), "true")----
# data[1:50, 1:15] |>
#   kableExtra::kbl() |>
#   kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
#   kableExtra::scroll_box(height = "300px", width = "100%",
#                          box_css = "border: 1px solid #ddd; padding: 5px; ",
#                          extra_css = NULL,
#                          fixed_thead = TRUE)

## ----sormas-login, eval=identical(Sys.getenv("NOT_CRAN"), "true")-------------
# # ESTABLISH THE CONNECTION TO THE SORMAS SYSTEM
# sormas_login <- login(
#   type = "sormas",
#   from = "https://demo.sormas.org/sormas-rest/",
#   user_name = "SurvSup",
#   password = "Lk5R7JXeZSEc"
# )
# 
# # GET THE LIST OF ALL AVAILABLE DISEASES IN THE TEST SORMAS SYSTEM
# disease_names <- sormas_get_diseases(
#   login = sormas_login
# )

## ----sormas-dict, eval=identical(Sys.getenv("NOT_CRAN"), "true")--------------
# # DOWNLOAD AND SAVE THE DATA DICTIONARY IN YOUR CURRENT DIRECTORY
# path_to_dictionary <- sormas_get_data_dictionary(path = getwd())
# path_to_dictionary

## ----sormas-cases, eval=identical(Sys.getenv("NOT_CRAN"), "true")-------------
# # FETCH ALL COVID (coronavirus) CASES FROM THE TEST SORMAS INSTANCE FROM THE
# # BEGINNING OF DATA COLLECTION
# covid_cases <- read_sormas(
#   login = sormas_login,
#   disease = "coronavirus",
#   since = 0
# )
# 
# # FETCH ALL COVID (coronavirus) CASES FROM THE TEST SORMAS INSTANCE SINCE
# # JUNE 01, 2025
# covid_cases <- read_sormas(
#   login = sormas_login,
#   disease = "coronavirus",
#   since = as.Date("2025-06-01")
# )

## ----display-cases, echo=FALSE, eval=identical(Sys.getenv("NOT_CRAN"), "true")----
# covid_cases[, 1:15] |>
#   kableExtra::kbl() |>
#   kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
#   kableExtra::scroll_box(height = "200px", width = "100%",
#                          box_css = "border: 1px solid #ddd; padding: 5px; ",
#                          extra_css = NULL,
#                          fixed_thead = TRUE)

