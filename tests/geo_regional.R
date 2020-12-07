# Geographical data
# ###################

library(tidyverse)
library(rgdal) #to import shapefiles
library(broom)

sf_regional =  readOGR("ComunidadesAutonomas_ETRS89_30N/Comunidades_Autonomas_ETRS89_30N.shp")

# geo to df ----------------------------------------
regional_df <- tidy(sf_regional)


temp_df <- data.frame(sf_regional$Texto)


temp_df$id_reg <- as.character(seq(0,nrow(temp_df)-1))


temp_df = temp_df %>%
  mutate(id_ense = seq(1:19),
         id_ense = str_pad(id_ense, 2, "left", "0")) %>%
  rename(ccaa = sf_regional.Texto )



# join egional data ---------------------------------

regional_df <- left_join(regional_df, temp_df, by=c("id" = "id_reg"))

# canary islands ------------------------------------

regional_map <- regional_df %>%
    mutate(lat_c = ifelse(lat <35e5, lat + 75e4, lat),
           long_c = ifelse(long <(-5e5), (long + 65e4), long))


canaries_line <- data.frame(long = c(-36e4, 15e4, 15e4),
                              lat = c(405e4, 405e4, 385e4))

usethis::use_data(regional_map, overwrite = T)

