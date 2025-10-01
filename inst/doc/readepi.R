## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk[["set"]](collapse = TRUE, comment = "#>", eval = FALSE,
                           fig.width = 7L, fig.height = 7L, message = FALSE,
                           fig.align = "center", warning = FALSE, dpi = 300L)

## ----setup, eval=TRUE---------------------------------------------------------
# LOAD readepi
library(readepi)

## -----------------------------------------------------------------------------
# # CONNECT TO A DHIS2 INSTANCE
# dhis2_login <- login(
#   type = "dhis2",
#   from  = "https://smc.moh.gm/dhis",
#   user_name = "test",
#   password  = "Gambia@123"
# )
# 
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
# 
# # CONNECT TO A SORMAS SYSTEM
# dhis2_login <- login(
#   type = "sormas",
#   from  = "https://demo.sormas.org/sormas-rest",
#   user_name = "SurvSup",
#   password  = "Lk5R7JXeZSEc"
# )

## ----eval=TRUE----------------------------------------------------------------
# CONNECT TO THE TEST MYSQL SERVER
rdbms_login <- login(
  type = "mysql",
  from = "mysql-rfam-public.ebi.ac.uk",
  user_name = "rfamro",
  password = "",
  driver_name = "",
  db_name = "Rfam",
  port = 4497
)

# DISPLAY THE LIST OF TABLES FROM A DATABASE OF INTEREST
tables <- show_tables(login = rdbms_login)
head(tables)

# READING ALL FIELDS AND ALL RECORDS FROM ONE TABLE (`author`) USING AN SQL
# QUERY
dat <- read_rdbms(
  login = rdbms_login,
  query = "select * from author"
)

# READING ALL FIELDS AND ALL RECORDS FROM ONE TABLE (`author`) WHERE QUERY
# PARAMETERS ARE SPECIFIED AS A LIST
dat <- read_rdbms(
  login = rdbms_login,
  query = list(table = "author", fields = NULL, filter = NULL)
)

# SELECT FEW COLUMNS FROM ONE TABLE AND LEFT JOIN WITH ANOTHER TABLE
dat <- read_rdbms(
    login = rdbms_login,
    query = "select author.author_id, author.name,
  family_author.author_id from author left join family_author on
  author.author_id = family_author.author_id"
)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
dat |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "200px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

## ----eval=TRUE----------------------------------------------------------------
# CONNECT TO A DHIS2 INSTANCE
dhis2_login <- login(
  type = "dhis2",
  from = "https://smc.moh.gm/dhis",
  user_name = "test",
  password = "Gambia@123"
)

## ----eval=TRUE----------------------------------------------------------------
# GET THE LIST OF ALL ORGANISATION UNITS IN AN HIERARCHICAL ORDER
org_units <- get_organisation_units(login = dhis2_login)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
org_units |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "200px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

## ----eval=TRUE----------------------------------------------------------------
# GET THE LIST OF ALL PROGRAMS
programs <- get_programs(login = dhis2_login)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
programs |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "200px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

## ----eval=TRUE----------------------------------------------------------------
# GET THE LIST OF ALL DATA ELEMENTS
data_elements <- get_data_elements(login = dhis2_login)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
data_elements |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "200px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

## ----eval=TRUE----------------------------------------------------------------
# GET THE LIST OF ALL PROGRAM STAGES FOR A GIVEN PROGRAM ID
program_stages <- get_program_stages(
  login = dhis2_login,
  program = "E5IUQuHg3Mg",
  programs = programs
)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
program_stages |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "200px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

## ----eval=TRUE----------------------------------------------------------------
# GET THE LIST OF ORGANISATION UNITS RUNNING THE SPECIFIED PROGRAM
target_org_units <- get_program_org_units(
    login = dhis2_login,
    program = "E5IUQuHg3Mg",
    org_units = org_units
  )

## ----echo=FALSE, eval=TRUE----------------------------------------------------
target_org_units |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "200px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

## ----eval=TRUE----------------------------------------------------------------
# IMPORT DATA FROM DHIS2 FOR THE SPECIFIED ORGANISATION UNIT AND PROGRAM IDs
data <- read_dhis2(
  login = dhis2_login,
  org_unit = "GcLhRNAFppR",
  program = "E5IUQuHg3Mg"
)

# IMPORT DATA FROM DHIS2 FOR THE SPECIFIED ORGANISATION UNIT AND PROGRAM NAMES
data <- read_dhis2(
  login = dhis2_login,
  org_unit = "Keneba",
  program = "Child Registration & Treatment "
)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
data[1:50, 1:15] |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "300px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

## ----eval=TRUE----------------------------------------------------------------
# ESTABLISH THE CONNECTION TO THE SORMAS SYSTEM
sormas_login <- login(
  type = "sormas",
  from = "https://demo.sormas.org/sormas-rest",
  user_name = "SurvSup",
  password = "Lk5R7JXeZSEc"
)

# GET THE LIST OF ALL AVAILABLE DISEASES IN THE TEST SORMAS SYSTEM
disease_names <- sormas_get_diseases(
  login = sormas_login
)

## ----eval=TRUE----------------------------------------------------------------
# DOWNLOAD AND SAVE THE DATA DICTIONARY IN YOUR CURRENT DIRECTORY
path_to_dictionary <- sormas_get_data_dictionary(path = getwd())
path_to_dictionary

## ----eval=TRUE----------------------------------------------------------------
# FETCH ALL COVID (coronavirus) CASES FROM THE TEST SORMAS INSTANCE FROM THE
# BEGINNING OF DATA COLLECTION
covid_cases <- read_sormas(
  login = sormas_login,
  disease = "coronavirus",
  since = 0
)

# FETCH ALL COVID (coronavirus) CASES FROM THE TEST SORMAS INSTANCE SINCE
# JUNE 01, 2025
covid_cases <- read_sormas(
  login = sormas_login,
  disease = "coronavirus",
  since = as.Date("2025-06-01")
)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
covid_cases[, 1:15] |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "200px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

