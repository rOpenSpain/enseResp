library(usethis)

use_r("ense_functions")

use_data_raw()

sinew::makeOxygen(adults, add_fields = "CCAA")
sinew::makeOxygen(adults_info_final)

devtools::load_all()

usethis::use_package_doc()
devtools::document()

package?enseResp

browse_github_pat()

use_readme_rmd()

use_logo("logo/hexlogo.png")


use_github(protocol = "https", auth_token = "63b9b9a3384cf2a77f8ef90d10637e129eb2af07")
