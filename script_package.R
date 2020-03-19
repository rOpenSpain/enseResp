library(usethis)

use_r("get_variable")

use_data_raw()

sinew::makeOxygen(children_19)
sinew::makeOxygen(children_19_info)
sinew::makeOxygen(household_19)
sinew::makeOxygen(household_19_info)


devtools::load_all()

usethis::use_package_doc()

devtools::document()

#Document
sinew::makeOxygen(get_region())
sinew::makeOxygen(get_variable())

package?enseResp

browse_github_pat()

dev_too


use_github(protocol = "https", auth_token = "63b9b9a3384cf2a77f8ef90d10637e129eb2af07")
