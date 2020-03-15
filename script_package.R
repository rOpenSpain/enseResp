library(usethis)

use_r("get_region")

use_data_raw()

# Document datasets

sinew::makeOxygen(adults, add_fields = "CCAA")
sinew::makeOxygen(adult_info)

# Document functions

sinew::makeOxygen(get_region())


devtools::load_all()

usethis::use_package_doc()
devtools::document()


# Git
browse_github_pat()

# Readme
use_readme_rmd()

# Add logo
use_logo("logo/hexlogo.png", geometry = "240x278", retina = TRUE)


use_github(protocol = "https", auth_token = "63b9b9a3384cf2a77f8ef90d10637e129eb2af07")
