library(usethis)
library(devtools)
devtools::install_github("r-lib/pkgdown")
library(pkgdown)

pkgdown::build_site()

use_r("get_variable")
use_r()

use_data_raw()

sinew::makeOxygen(children_19)
sinew::makeOxygen(children_19_info)
sinew::makeOxygen(household_19)
sinew::makeOxygen(household_19_info)

use_r("get_region")

use_data_raw()

# Document datasets

sinew::makeOxygen(adults, add_fields = "CCAA")
sinew::makeOxygen(adult_info)

# Document functions


devtools::load_all()

usethis::use_package_doc()

devtools::document()


#Document
sinew::makeOxygen(get_region())
sinew::makeOxygen(get_variable())

package?enseResp

# Git
browse_github_pat()



# Readme
use_readme_rmd()

# Add logo
use_logo("logo/hexlogo.png", geometry = "240x278", retina = TRUE)



use_github(protocol = "https", auth_token = "63b9b9a3384cf2a77f8ef90d10637e129eb2af07")
