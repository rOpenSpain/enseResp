## Prepare adults ENSE 2023 datasets
##
## Source files (documentation/ense23/Adultos_2023/):
##   - Diseno_cuestionario_adulto.xlsx  (design: sheet 1 = variable info, sheet 2 = labels)
##   - md_ESdEadulto_2023.txt           (fixed-width microdata)

library(tidyverse)
library(readxl)
library(janitor)

source("funs/funs_data.R")

# ---- 1. Variable metadata ---------------------------------------------------

adults_23_raw_info <- read_excel(
  "documentation/ense23/Adultos_2023/Diseno_cuestionario_adulto.xlsx",
  range = "A8:E700"   # adjust upper bound if there are more variables
) |>
  janitor::clean_names()

adults_23_info <- parse_info(adults_23_raw_info, variable_ine)

# ---- 2. Value labels --------------------------------------------------------

adults_23_raw_labels <- read_excel(
  "documentation/ense23/Adultos_2023/Diseno_cuestionario_adulto.xlsx",
  sheet = 2,
  range = "A8:C5000"  # adjust upper bound if needed
)

adults_23_labels <- parse_labels(adults_23_raw_labels)

# ---- 3. Microdata -----------------------------------------------------------

adults_23 <- readr::read_fwf(
  file = "documentation/ense23/Adultos_2023/md_ESdEadulto_2023.txt",
  skip = 0,
  readr::fwf_positions(
    adults_23_info$posicion_inicio,
    adults_23_info$posicion_final,
    adults_23_info$variable_ine
  )
)

# ---- 4. Save ----------------------------------------------------------------

usethis::use_data(adults_23, adults_23_info, adults_23_labels, overwrite = TRUE)
