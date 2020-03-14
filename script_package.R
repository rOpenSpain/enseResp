library(usethis)

use_r("ense_functions")

use_data_raw()

sinew::makeOxygen(adults, add_fields = "CCAA")
sinew::makeOxygen(adults_info_final)

devtools::load_all()

usethis::use_package_doc()
devtools::document()

package?enseResp
