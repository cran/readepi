## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# ## AS A LIST
# read_rdbms(
#   login = rdbms_login,
#   query = list(
#     table  = "author",
#     fields = c("name", "last_name", "orcid"),
#     filter = 1:10
#   )
# )
# 
# ## AS AN SQL QUERY - FOR MySQL server
# read_rdbms(
#   login = rdbms_login,
#   query = "SELECT name, last_name, orcid FROM author LIMIT 10"
# )

## -----------------------------------------------------------------------------
readepi::request_parameters |>
  kableExtra::kbl() |>
  kableExtra::kable_paper("striped", font_size = 14, full_width = TRUE) |>
  kableExtra::scroll_box(height = "200px", width = "100%",
                         box_css = "border: 1px solid #ddd; padding: 5px; ",
                         extra_css = NULL,
                         fixed_thead = TRUE)

