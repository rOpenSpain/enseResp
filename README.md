
<!-- README.md is generated from README.Rmd. Please edit that file -->

# enseResp <img src='man/figures/logo.png' align="right" height="138.5" />

<!-- badges: start -->

<!-- badges: end -->

`enseResp` is a R package to tidily access healthcare data from the
Spanish Health Survey released by the Spanish Health Ministry. The main
goal of `enseResp` is to provide data ready for analysis for researchers
or other stakeholders interested in exploring health microdata in Spain.
The current version of `enseResp` consists of the survey corresponding
to 2017/19 and compiles the surveys associated with the adult, children
and household samples.

## Installation

You can install the released version of enseResp from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("enseResp")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("edugonzaloalmorox/enseResp")
```

## Load main datasets

This is a basic example of how to obtain a dataset. For example, the
survey of adults corresponding to 2017-19 survey.

``` r
library(enseResp)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union


enseResp::adults_19
#> # A tibble: 23,089 x 455
#>    CCAA  IDENTHOGAR A7_2a SEXOa EDADa ACTIVa PROXY_0 PROXY_1 PROXY_2 PROXY_2b
#>    <chr> <chr>      <chr> <dbl> <chr>  <dbl>   <dbl>   <dbl>   <dbl> <chr>   
#>  1 16    00001011   01        2 084        3       1      NA      NA <NA>    
#>  2 16    00001021   04        1 026        1       1      NA      NA <NA>    
#>  3 16    00001041   02        2 056        5       1      NA      NA <NA>    
#>  4 16    00001051   01        1 070        3       1      NA      NA <NA>    
#>  5 16    00001071   01        1 061        3       1      NA      NA <NA>    
#>  6 16    00001091   01        2 035        1       1      NA      NA <NA>    
#>  7 16    00001101   01        2 055        1       1      NA      NA <NA>    
#>  8 16    00001131   02        1 038        1       1      NA      NA <NA>    
#>  9 16    00001151   01        1 039        2       1      NA      NA <NA>    
#> 10 16    00002011   01        2 080        3       1      NA      NA <NA>    
#> # … with 23,079 more rows, and 445 more variables: PROXY_3b <dbl>,
#> #   PROXY_4 <chr>, PROXY_5 <dbl>, E1_1 <dbl>, E2_1a <dbl>, E2_1b <dbl>,
#> #   E2_1c <dbl>, E2_1d <dbl>, E3 <chr>, E4 <dbl>, E4b <dbl>, NIVEST <chr>,
#> #   F6 <dbl>, F7 <dbl>, F8_2 <chr>, F9_2 <chr>, F10 <dbl>, F11 <dbl>,
#> #   F12 <dbl>, F13 <chr>, F14a <dbl>, F14b <dbl>, F15 <dbl>, F16 <dbl>,
#> #   F17 <chr>, F18a_2 <chr>, F18b_2 <chr>, F19a_2 <dbl>, F19b_2 <chr>,
#> #   F20 <dbl>, G21 <dbl>, G22 <dbl>, G23 <dbl>, G24 <dbl>, G25a_1 <dbl>,
#> #   G25b_1 <dbl>, G25c_1 <dbl>, G25a_2 <dbl>, G25b_2 <dbl>, G25c_2 <dbl>,
#> #   G25a_3 <dbl>, G25b_3 <dbl>, G25c_3 <dbl>, G25a_4 <dbl>, G25b_4 <dbl>,
#> #   G25c_4 <dbl>, G25a_5 <dbl>, G25b_5 <dbl>, G25c_5 <dbl>, G25a_6 <dbl>,
#> #   G25b_6 <dbl>, G25c_6 <dbl>, G25a_7 <dbl>, G25b_7 <dbl>, G25c_7 <dbl>,
#> #   G25a_8 <dbl>, G25b_8 <dbl>, G25c_8 <dbl>, G25a_9 <dbl>, G25b_9 <dbl>,
#> #   G25c_9 <dbl>, G25a_10 <dbl>, G25b_10 <dbl>, G25c_10 <dbl>, G25a_11 <dbl>,
#> #   G25b_11 <dbl>, G25c_11 <dbl>, G25a_12 <dbl>, G25b_12 <dbl>, G25c_12 <dbl>,
#> #   G25a_13 <dbl>, G25b_13 <dbl>, G25c_13 <dbl>, G25a_14 <dbl>, G25b_14 <dbl>,
#> #   G25c_14 <dbl>, G25a_15 <dbl>, G25b_15 <dbl>, G25c_15 <dbl>, G25a_16 <dbl>,
#> #   G25b_16 <dbl>, G25c_16 <dbl>, G25a_17 <dbl>, G25b_17 <dbl>, G25c_17 <dbl>,
#> #   G25a_18 <dbl>, G25b_18 <dbl>, G25c_18 <dbl>, G25a_19 <dbl>, G25b_19 <dbl>,
#> #   G25c_19 <dbl>, G25a_20 <dbl>, G25b_20 <dbl>, G25c_20 <dbl>, G25a_21 <dbl>,
#> #   G25b_21 <dbl>, G25c_21 <dbl>, G25a_22 <dbl>, G25b_22 <dbl>, G25c_22 <dbl>,
#> #   …
```

`adults_19` contains 455 variables. `adults_19_info` provides
information about the description of every variable (in Spanish). In
addition it offers other information such as the type of variable, the
positions in the text archive or the module the variable belongs to
(European Health Survey)

``` r
library(enseResp)
library(dplyr)
library(knitr)

enseResp::adults_19_info %>% 
  select(variable_ine, descripcion_del_campo) %>% kable()
```

| variable\_ine | descripcion\_del\_campo                                                                                                                                              |
| :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CCAA          | Comunidad Autónoma de residencia                                                                                                                                     |
| IDENTHOGAR    | Número de identificación del hogar: Sección + Vivienda + Hogar                                                                                                       |
| A7\_2a        | Número de orden del adulto seleccionado                                                                                                                              |
| SEXOa         | Identificación del adulto seleccionado: Sexo                                                                                                                         |
| EDADa         | Identificación del adulto seleccionado: Edad                                                                                                                         |
| ACTIVa        | Identificación del adulto seleccionado: Actividad económica actual                                                                                                   |
| PROXY\_0      | ¿El informante es la persona seleccionada?                                                                                                                           |
| PROXY\_1      | Informante proxy: ¿Cuál es el motivo por el que la persona seleccionada no facilita sus datos?                                                                       |
| PROXY\_2      | Informante proxy: ¿Es miembro del hogar el informante?                                                                                                               |
| PROXY\_2b     | Informante proxy: Número de orden del miembro del hogar                                                                                                              |
| PROXY\_3b     | Informante proxy: Sexo del informante                                                                                                                                |
| PROXY\_4      | Informante proxy: Edad del informante                                                                                                                                |
| PROXY\_5      | Informante proxy: Relación del informante con el adulto seleccionado                                                                                                 |
| E1\_1         | País de nacimiento                                                                                                                                                   |
| E2\_1a        | Nacionalidad: Española                                                                                                                                               |
| E2\_1b        | Nacionalidad: Extranjera                                                                                                                                             |
| E2\_1c        | Nacionalidad: No sabe                                                                                                                                                |
| E2\_1d        | Nacionalidad: No contesta                                                                                                                                            |
| E3            | Años residiendo en España                                                                                                                                            |
| E4            | Convivencia en pareja                                                                                                                                                |
| E4b           | Estado civil                                                                                                                                                         |
| NIVEST        | Nivel de estudios del adulto seleccionado                                                                                                                            |
| F6            | Adulto seleccionado: ¿Percibe pensión contributiva?                                                                                                                  |
| F7            | Adulto seleccionado: ¿Ha trabajado antes?                                                                                                                            |
| F8\_2         | Persona que generó la pensión: Actividad de la empresa en la que trabajó (código CNAE2009, 3 dígitos)                                                                |
| F9\_2         | Persona que generó la pensión: Ocupación, profesión u oficio (código CNO2011, 3 dígitos)                                                                             |
| F10           | Persona que generó la pensión: Situación profesional en la ocupación que desempeñó                                                                                   |
| F11           | Adulto seleccionado: Tiempo que lleva desempleado                                                                                                                    |
| F12           | Adulto seleccionado: ¿Ha trabajado antes?                                                                                                                            |
| F13           | Adulto seleccionado: Tipo de contrato o relación laboral                                                                                                             |
| F14a          | Adulto seleccionado: Duración del contrato                                                                                                                           |
| F14b          | Adulto seleccionado: Duración de la relación laboral                                                                                                                 |
| F15           | Adulto seleccionado: Número de trabajadores a su cargo                                                                                                               |
| F16           | Adulto seleccionado: Trabajo a tiempo completo / tiempo parcial                                                                                                      |
| F17           | Adulto seleccionado: Tipo de jornada en su trabajo principal actual                                                                                                  |
| F18a\_2       | Adulto seleccionado: Actividad de la empresa en la que trabaja (código CNAE2009, 3 dígitos)                                                                          |
| F18b\_2       | Adulto seleccionado: Actividad de la empresa en la que trabajó (código CNAE2009, 3 dígitos)                                                                          |
| F19a\_2       | Adulto seleccionado: Ocupación, profesión u oficio actual (código CNO2011, 3 dígitos)                                                                                |
| F19b\_2       | Adulto seleccionado: Última ocupación, profesión u oficio (código CNO2011, 3 dígitos)                                                                                |
| F20           | Adulto seleccionado: Situación profesional que desempeñó en su último empleo                                                                                         |
| G21           | Estado de salud percibido en los últimos 12 meses                                                                                                                    |
| G22           | Enfermedad o problema de salud crónicos o de larga duración                                                                                                          |
| G23           | Grado de limitación durante al menos 6 meses por un problema de salud                                                                                                |
| G24           | Tipo de problema que causa la dificultad                                                                                                                             |
| G25a\_1       | Ha padecido alguna vez: Tensión alta                                                                                                                                 |
| G25b\_1       | Ha padecido en los últimos 12 meses: Tensión alta                                                                                                                    |
| G25c\_1       | Diagnóstico médico: Tensión alta                                                                                                                                     |
| G25a\_2       | Ha padecido alguna vez: Infarto de miocardio                                                                                                                         |
| G25b\_2       | Ha padecido en los últimos 12 meses: Infarto de miocardio                                                                                                            |
| G25c\_2       | Diagnóstico médico: Infarto de miocardio                                                                                                                             |
| G25a\_3       | Ha padecido alguna vez: Angina de pecho, enfermedad coronaria                                                                                                        |
| G25b\_3       | Ha padecido en los últimos 12 meses: Angina de pecho, enfermedad coronaria                                                                                           |
| G25c\_3       | Diagnóstico médico: Angina de pecho, enfermedad coronaria                                                                                                            |
| G25a\_4       | Ha padecido alguna vez: Otras enfermedades del corazón                                                                                                               |
| G25b\_4       | Ha padecido en los últimos 12 meses: Otras enfermedades del corazón                                                                                                  |
| G25c\_4       | Diagnóstico médico: Otras enfermedades del corazón                                                                                                                   |
| G25a\_5       | Ha padecido alguna vez: Varices en las piernas                                                                                                                       |
| G25b\_5       | Ha padecido en los últimos 12 meses: Varices en las piernas                                                                                                          |
| G25c\_5       | Diagnóstico médico: Varices en las piernas                                                                                                                           |
| G25a\_6       | Ha padecido alguna vez: Artrosis (excluyendo artritis)                                                                                                               |
| G25b\_6       | Ha padecido en los últimos 12 meses: Artrosis (excluyendo artritis)                                                                                                  |
| G25c\_6       | Diagnóstico médico: Artrosis (excluyendo artritis)                                                                                                                   |
| G25a\_7       | Ha padecido alguna vez: Dolor de espalda crónico (cervical)                                                                                                          |
| G25b\_7       | Ha padecido en los últimos 12 meses: Dolor de espalda crónico (cervical)                                                                                             |
| G25c\_7       | Diagnóstico médico: Dolor de espalda crónico (cervical)                                                                                                              |
| G25a\_8       | Ha padecido alguna vez: Dolor de espalda crónico (lumbar)                                                                                                            |
| G25b\_8       | Ha padecido en los últimos 12 meses: Dolor de espalda crónico (lumbar)                                                                                               |
| G25c\_8       | Diagnóstico médico: Dolor de espalda crónico (lumbar)                                                                                                                |
| G25a\_9       | Ha padecido alguna vez: Alergia crónica, como rinitis, conjuntivitis o dermatitis alérgica, alergia alimentaria o de otro tipo (asma alérgica excluida)              |
| G25b\_9       | Ha padecido en los últimos 12 meses: Alergia crónica, como rinitis, conjuntivitis o dermatitis alérgica, alergia alimentaria o de otro tipo (asma alérgica excluida) |
| G25c\_9       | Diagnóstico médico: Alergia crónica, como rinitis, conjuntivitis o dermatitis alérgica, alergia alimentaria o de otro tipo (asma alérgica excluida)                  |
| G25a\_10      | Ha padecido alguna vez: Asma (incluida asma alérgica)                                                                                                                |
| G25b\_10      | Ha padecido en los últimos 12 meses: Asma (incluida asma alérgica)                                                                                                   |
| G25c\_10      | Diagnóstico médico: Asma (incluida asma alérgica)                                                                                                                    |
| G25a\_11      | Ha padecido alguna vez: Bronquitis crónica, enfisema, enfermedad pulmonar obstructiva crónica (EPOC)                                                                 |
| G25b\_11      | Ha padecido en los últimos 12 meses: Bronquitis crónica, enfisema, enfermedad pulmonar obstructiva crónica (EPOC)                                                    |
| G25c\_11      | Diagnóstico médico: Bronquitis crónica, enfisema, enfermedad pulmonar obstructiva crónica (EPOC)                                                                     |
| G25a\_12      | Ha padecido alguna vez: Diabetes                                                                                                                                     |
| G25b\_12      | Ha padecido en los últimos 12 meses: Diabetes                                                                                                                        |
| G25c\_12      | Diagnóstico médico: Diabetes                                                                                                                                         |
| G25a\_13      | Ha padecido alguna vez: Úlcera de estómago o duodeno                                                                                                                 |
| G25b\_13      | Ha padecido en los últimos 12 meses: Úlcera de estómago o duodeno                                                                                                    |
| G25c\_13      | Diagnóstico médico: Úlcera de estómago o duodeno                                                                                                                     |
| G25a\_14      | Ha padecido alguna vez: Incontinencia urinaria o problemas de control de la orina                                                                                    |
| G25b\_14      | Ha padecido en los últimos 12 meses: Incontinencia urinaria o problemas de control de la orina                                                                       |
| G25c\_14      | Diagnóstico médico: Incontinencia urinaria o problemas de control de la orina                                                                                        |
| G25a\_15      | Ha padecido alguna vez: Colesterol alto                                                                                                                              |
| G25b\_15      | Ha padecido en los últimos 12 meses: Colesterol alto                                                                                                                 |
| G25c\_15      | Diagnóstico médico: Colesterol alto                                                                                                                                  |
| G25a\_16      | Ha padecido alguna vez: Cataratas                                                                                                                                    |
| G25b\_16      | Ha padecido en los últimos 12 meses: Cataratas                                                                                                                       |
| G25c\_16      | Diagnóstico médico: Cataratas                                                                                                                                        |
| G25a\_17      | Ha padecido alguna vez: Problemas crónicos de piel                                                                                                                   |
| G25b\_17      | Ha padecido en los últimos 12 meses: Problemas crónicos de piel                                                                                                      |
| G25c\_17      | Diagnóstico médico: Problemas crónicos de piel                                                                                                                       |
| G25a\_18      | Ha padecido alguna vez: Estreñimiento crónico                                                                                                                        |
| G25b\_18      | Ha padecido en los últimos 12 meses: Estreñimiento crónico                                                                                                           |
| G25c\_18      | Diagnóstico médico: Estreñimiento crónico                                                                                                                            |
| G25a\_19      | Ha padecido alguna vez: Cirrosis, disfunción hepática                                                                                                                |
| G25b\_19      | Ha padecido en los últimos 12 meses: Cirrosis, disfunción hepática                                                                                                   |
| G25c\_19      | Diagnóstico médico: Cirrosis, disfunción hepática                                                                                                                    |
| G25a\_20      | Ha padecido alguna vez: Depresión                                                                                                                                    |
| G25b\_20      | Ha padecido en los últimos 12 meses: Depresión                                                                                                                       |
| G25c\_20      | Diagnóstico médico: Depresión                                                                                                                                        |
| G25a\_21      | Ha padecido alguna vez: Ansiedad crónica                                                                                                                             |
| G25b\_21      | Ha padecido en los últimos 12 meses: Ansiedad crónica                                                                                                                |
| G25c\_21      | Diagnóstico médico: Ansiedad crónica                                                                                                                                 |
| G25a\_22      | Ha padecido alguna vez: Otros problemas mentales                                                                                                                     |
| G25b\_22      | Ha padecido en los últimos 12 meses: Otros problemas mentales                                                                                                        |
| G25c\_22      | Diagnóstico médico: Otros problemas mentales                                                                                                                         |
| G25a\_23      | Ha padecido alguna vez: Ictus (embolia, infarto cerebral, hemorragia cerebral)                                                                                       |
| G25b\_23      | Ha padecido en los últimos 12 meses: Ictus (embolia, infarto cerebral, hemorragia cerebral)                                                                          |
| G25c\_23      | Diagnóstico médico: Ictus (embolia, infarto cerebral, hemorragia cerebral)                                                                                           |
| G25a\_24      | Ha padecido alguna vez: Migraña o dolor de cabeza frecuente                                                                                                          |
| G25b\_24      | Ha padecido en los últimos 12 meses: Migraña o dolor de cabeza frecuente                                                                                             |
| G25c\_24      | Diagnóstico médico: Migraña o dolor de cabeza frecuente                                                                                                              |
| G25a\_25      | Ha padecido alguna vez: Hemorroides                                                                                                                                  |
| G25b\_25      | Ha padecido en los últimos 12 meses: Hemorroides                                                                                                                     |
| G25c\_25      | Diagnóstico médico: Hemorroides                                                                                                                                      |
| G25a\_26      | Ha padecido alguna vez: Tumores malignos                                                                                                                             |
| G25b\_26      | Ha padecido en los últimos 12 meses: Tumores malignos                                                                                                                |
| G25c\_26      | Diagnóstico médico: Tumores malignos                                                                                                                                 |
| G25a\_27      | Ha padecido alguna vez: Osteoporosis                                                                                                                                 |
| G25b\_27      | Ha padecido en los últimos 12 meses: Osteoporosis                                                                                                                    |
| G25c\_27      | Diagnóstico médico: Osteoporosis                                                                                                                                     |
| G25a\_28      | Ha padecido alguna vez: Problemas de tiroides                                                                                                                        |
| G25b\_28      | Ha padecido en los últimos 12 meses: Problemas de tiroides                                                                                                           |
| G25c\_28      | Diagnóstico médico: Problemas de tiroides                                                                                                                            |
| G25a\_29      | Ha padecido alguna vez: Problemas de riñón                                                                                                                           |
| G25b\_29      | Ha padecido en los últimos 12 meses: Problemas de riñón                                                                                                              |
| G25c\_29      | Diagnóstico médico: Problemas de riñón                                                                                                                               |
| G25a\_30      | Ha padecido alguna vez: Problemas de próstata (solo hombres)                                                                                                         |
| G25b\_30      | Ha padecido en los últimos 12 meses: Problemas de próstata (solo hombres)                                                                                            |
| G25c\_30      | Diagnóstico médico: Problemas de próstata (solo hombres)                                                                                                             |
| G25a\_31      | Ha padecido alguna vez: Problemas del periodo menopáusico (solo mujeres)                                                                                             |
| G25b\_31      | Ha padecido en los últimos 12 meses: Problemas del periodo menopáusico (solo mujeres)                                                                                |
| G25c\_31      | Diagnóstico médico: Problemas del periodo menopáusico (solo mujeres)                                                                                                 |
| G25a\_32      | Ha padecido alguna vez: Lesiones o defectos permanentes causados por un accidente                                                                                    |
| G25b\_32      | Ha padecido en los últimos 12 meses: Lesiones o defectos permanentes causados por un accidente                                                                       |
| G25c\_32      | Diagnóstico médico: Lesiones o defectos permanentes causados por un accidente                                                                                        |
| H26\_1        | Ha tenido en los últimos 12 meses: Accidente de tráfico                                                                                                              |
| H26\_2        | Ha tenido en los últimos 12 meses: Accidente en casa                                                                                                                 |
| H26\_3        | Ha tenido en los últimos 12 meses: Accidente durante su tiempo libre                                                                                                 |
| H27           | Intervención sanitaria debida al accidente más grave                                                                                                                 |
| I28\_1        | Restricción de la actividad habitual en las últimas dos semanas                                                                                                      |
| I28\_2        | Número de días de restricción de la actividad habitual                                                                                                               |
| I29\_1        | Permanencia en cama en las últimas dos semanas                                                                                                                       |
| I29\_2        | Número de días de permanencia en cama                                                                                                                                |
| K32           | ¿Utiliza gafas o lentillas?                                                                                                                                          |
| K33           | Dificultad para ver                                                                                                                                                  |
| K34           | ¿Utiliza audífono?                                                                                                                                                   |
| K35           | Dificultad para oir en un sitio tranquilo                                                                                                                            |
| K36           | Dificultad para oir en un sitio más ruidoso                                                                                                                          |
| K37           | Dificultad para caminar 500 metros sin ayuda                                                                                                                         |
| K38           | Dificultad para subir o bajar 12 escalones                                                                                                                           |
| K38a          | Dificultad para recordar o concentrarse                                                                                                                              |
| L39\_1        | Dificultad para actividades básicas diarias: Alimentarse sin ayuda                                                                                                   |
| L39\_2        | Dificultad para actividades básicas diarias: Sentarse, levantarse de una silla o de una cama, acostarse sin ayuda                                                    |
| L39\_3        | Dificultad para actividades básicas diarias: Vestirse y desvestirse sin ayuda                                                                                        |
| L39\_4        | Dificultad para actividades básicas diarias: Ir al servicio sin ayuda                                                                                                |
| L39\_5        | Dificultad para actividades básicas diarias: Ducharse o bañarse sin ayuda                                                                                            |
| L40           | ¿Dispone habitualmente de ayuda para realizarlas?                                                                                                                    |
| L41           | ¿Necesitaría ayuda o más ayuda de la que dispone?                                                                                                                    |
| L42\_1        | Dificultad para actividades relacionadas con el hogar: Preparar las comidas sin ayuda                                                                                |
| L42\_2        | Dificultad para actividades relacionadas con el hogar: Utilizar el teléfono sin ayuda                                                                                |
| L42\_3        | Dificultad para actividades relacionadas con el hogar: Realizar compras sin ayuda                                                                                    |
| L42\_4        | Dificultad para actividades relacionadas con el hogar: Tomar sus medicamentos sin ayuda                                                                              |
| L42\_5        | Dificultad para actividades relacionadas con el hogar: Realizar tareas domésticas ligeras sin ayuda                                                                  |
| L42\_6        | Dificultad para actividades relacionadas con el hogar: Realizar ocasionalmente tareas domésticas que requieren un gran esfuerzo sin ayuda                            |
| L42\_7        | Dificultad para actividades relacionadas con el hogar: Administrar su propio dinero sin ayuda                                                                        |
| L43           | ¿Dispone habitualmente de ayuda para realizarlas?                                                                                                                    |
| L44           | ¿Necesitaría ayuda o más ayuda de la que dispone?                                                                                                                    |
| L45           | Grado de dolor padecido durante las últimas 4 semanas                                                                                                                |
| L46           | ¿Hasta qué punto el dolor afectó a sus actividades cotidianas?                                                                                                       |
| M47\_1        | Frecuencia en las últimas semanas: Ha podido concentrarse bien en lo que hacía                                                                                       |
| M47\_2        | Frecuencia en las últimas semanas: Sus preocupaciones le han hecho perder mucho sueño                                                                                |
| M47\_3        | Frecuencia en las últimas semanas: Ha sentido que está desempeñando un papel útil en la vida                                                                         |
| M47\_4        | Frecuencia en las últimas semanas: Se ha sentido capaz de tomar decisiones                                                                                           |
| M47\_5        | Frecuencia en las últimas semanas: Se ha notado constantemente agobiado y en tensión                                                                                 |
| M47\_6        | Frecuencia en las últimas semanas: Ha tenido la sensación de que no puede superar sus dificultades                                                                   |
| M47\_7        | Frecuencia en las últimas semanas: Ha sido capaz de disfrutar de sus actividades normales de cada día                                                                |
| M47\_8        | Frecuencia en las últimas semanas: Ha sido capaz de hacer frente adecuadamente a sus problemas                                                                       |
| M47\_9        | Frecuencia en las últimas semanas: Se ha sentido poco feliz o deprimido                                                                                              |
| M47\_10       | Frecuencia en las últimas semanas: Ha perdido confianza en sí mismo                                                                                                  |
| M47\_11       | Frecuencia en las últimas semanas: Ha pensado que usted es una persona que no vale para nada                                                                         |
| M47\_12       | Frecuencia en las últimas semanas: Se siente razonablemente feliz consideranto todas las circunstancias                                                              |
| M47a          | Condiciones en que realiza el trabajo: nivel de estrés                                                                                                               |
| M47b          | Condiciones en que realiza el trabajo: trabajo satisfactorio                                                                                                         |
| N48           | Tiempo desde la última consulta al médico general o de familia                                                                                                       |
| N49           | Número de consultas a un médico general o de familia en las cuatro últimas semanas                                                                                   |
| N50           | Tiempo desde la última consulta a un médico especialista                                                                                                             |
| N51           | Número de consultas a un médico especialista en las cuatro últimas semanas                                                                                           |
| N52           | Último médico consultado                                                                                                                                             |
| N53           | Lugar de la última consulta en estas cuatro semanas                                                                                                                  |
| N54           | Motivo principal de esta última consulta                                                                                                                             |
| N55\_1        | Tiempo en meses desde estar enfermo hasta pedir cita en esta última consulta                                                                                         |
| N55\_2        | Tiempo en días desde estar enfermo hasta pedir cita en esta última consulta                                                                                          |
| N55\_3        | Tiempo en horas desde estar enfermo hasta pedir cita en esta última consulta                                                                                         |
| N56\_1        | Tiempo en meses desde que pidió cita hasta que fue atendido                                                                                                          |
| N56\_2        | Tiempo en días desde que pidió cita hasta que fue atendido                                                                                                           |
| N56\_3        | Tiempo en horas desde que pidió cita hasta que fue atendido                                                                                                          |
| N57           | Dependencia funcional del médico                                                                                                                                     |
| N58\_1        | Visita durante los últimos 12 meses a: Fisioterapeuta                                                                                                                |
| N58\_2        | Visita durante los últimos 12 meses a: Psicólogo, psicoterapeuta o psiquiatra                                                                                        |
| N58\_3        | Visita durante los últimos 12 meses a: Enfermero/a, matrona                                                                                                          |
| N59           | Realización de análisis en los últimos 12 meses                                                                                                                      |
| N60\_1        | Pruebas durante los últimos 12 meses: Radiografía                                                                                                                    |
| N60\_2        | Pruebas durante los últimos 12 meses: TAC o escáner                                                                                                                  |
| N60\_3        | Pruebas durante los últimos 12 meses: Ecografía                                                                                                                      |
| N60\_4        | Pruebas durante los últimos 12 meses: Resonancia magnética                                                                                                           |
| N60a\_1       | Visitas durante los últimos 12 meses: Homeópata                                                                                                                      |
| N60a\_2       | Visitas durante los últimos 12 meses: Acupuntor                                                                                                                      |
| N60a\_3       | Visitas durante los últimos 12 meses: Naturista                                                                                                                      |
| N60a\_4       | Visitas durante los últimos 12 meses: Otro profesional de medicina alternativa (osteópata, quiropráctico…)                                                           |
| N61\_1        | Servicios asistenciales en los últimos 12 meses: Atención domiciliaria prestada por enfermero/a o matrona                                                            |
| N61\_2        | Servicios asistenciales en los últimos 12 meses: Ayuda domiciliaria para las tareas domésticas o para las personas mayores                                           |
| N61\_3        | Servicios asistenciales en los últimos 12 meses: Comidas a domicilio para personas mayores                                                                           |
| N61\_4        | Servicios asistenciales en los últimos 12 meses: Servicios especiales de transporte a domicilio                                                                      |
| N61\_5        | Servicios asistenciales en los últimos 12 meses: Otros servicios de asistencia domiciliaria                                                                          |
| N62           | Tiempo desde la última consulta al dentista, estomatólogo o higienista dental                                                                                        |
| N62b          | Nº de veces que visitó al dentista, estomatólogo o higienista dental en los últimos 3 meses                                                                          |
| N63\_1        | Tipo de asistencia: Revisión o chequeo                                                                                                                               |
| N63\_2        | Tipo de asistencia: Limpieza de boca                                                                                                                                 |
| N63\_3        | Tipo de asistencia: Empastes (obturaciones), endodoncias                                                                                                             |
| N63\_4        | Tipo de asistencia: Extracción de algún diente/muela                                                                                                                 |
| N63\_5        | Tipo de asistencia: Fundas, puentes u otro tipo de prótesis                                                                                                          |
| N63\_6        | Tipo de asistencia: Tratamiento de las enfermedades de las encías                                                                                                    |
| N63\_7        | Tipo de asistencia: Ortodoncia                                                                                                                                       |
| N63\_8        | Tipo de asistencia: Aplicación de flúor                                                                                                                              |
| N63\_9        | Tipo de asistencia: Implantes                                                                                                                                        |
| N63\_10       | Tipo de asistencia: Otro tipo                                                                                                                                        |
| N64           | Dependencia funcional del dentista consultado en la última visita                                                                                                    |
| N65\_1        | Estado de dientes y muelas: Tiene caries                                                                                                                             |
| N65\_2        | Estado de dientes y muelas: Le han extraído dientes/muelas                                                                                                           |
| N65\_3        | Estado de dientes y muelas: Tiene dientes/muelas empastados (obturados)                                                                                              |
| N65\_4        | Estado de dientes y muelas: Le sangran las encías al cepillarse o espontáneamente                                                                                    |
| N65\_5        | Estado de dientes y muelas: Se le mueven los dientes/muelas                                                                                                          |
| N65\_6        | Estado de dientes y muelas: Lleva fundas (coronas), puentes, otras prótesis o dentadura postiza                                                                      |
| N65\_7        | Estado de dientes y muelas: Le faltan dientes/muelas que no han sido sustituidos por prótesis                                                                        |
| N65\_8        | Estado de dientes y muelas: Tiene o conserva todos sus dientes/muelas naturales                                                                                      |
| O66           | Ingreso en hospital en los últimos 12 meses, excluyendo parto o cesárea                                                                                              |
| O67           | Número de veces ingresado en un hospital en los últimos 12 meses, excluyendo parto o cesárea                                                                         |
| O69           | Ingreso en hospital en los últimos 12 meses debido a parto o cesárea                                                                                                 |
| O70           | Número de días ingresado en el hospital la última vez                                                                                                                |
| O71           | Motivo del último ingreso en el hospital                                                                                                                             |
| O72           | ¿Estuvo en lista de espera para el último ingreso?                                                                                                                   |
| O73           | Número de meses en lista de espera                                                                                                                                   |
| O74           | ¿A cargo de quién corrieron los gastos de hospitalización?                                                                                                           |
| O75           | Ingreso en hospital de día en los últimos 12 meses                                                                                                                   |
| O76           | Número de ingresos en un hospital de día en los últimos 12 meses                                                                                                     |
| O77           | Motivo del último ingreso en un hospital de día                                                                                                                      |
| O78           | Utilización del servicio de urgencias en los últimos 12 meses                                                                                                        |
| O79           | Número de veces que utilizó el servicio de urgencias en los últimos 12 meses                                                                                         |
| O80\_1        | Lugar de atención del último servicio de urgencias: Lugar donde se encontraba                                                                                        |
| O80\_2        | Lugar de atención del último servicio de urgencias: Unidad móvil                                                                                                     |
| O80\_3        | Lugar de atención del último servicio de urgencias: Centro o servicio de urgencias                                                                                   |
| O81\_1        | Tiempo desde que se sintió enfermo hasta que pidió asistencia urgente (último servicio de urgencias utilizado): Días                                                 |
| O81\_2        | Tiempo desde que se sintió enfermo hasta que pidió asistencia urgente (último servicio de urgencias utilizado): Horas                                                |
| O81\_3        | Tiempo desde que se sintió enfermo hasta que pidió asistencia urgente (último servicio de urgencias utilizado): Minutos                                              |
| O82\_1        | Tiempo desde que pidió asistencia urgente hasta que fue atendido (último servicio de urgencias utilizado): Horas                                                     |
| O82\_2        | Tiempo desde que pidió asistencia urgente hasta que fue atendido (último servicio de urgencias utilizado): Minutos                                                   |
| O83           | Tipo de servicio de urgencias utilizado la última vez                                                                                                                |
| O84\_1        | Modalidad de seguro sanitario: Sanidad Pública (Seguridad Social)                                                                                                    |
| O84\_2        | Modalidad de seguro sanitario: Mutualidades del Estado (MUFACE, ISFAS, MUGEJU) acogidas a la Seguridad Social                                                        |
| O84\_3        | Modalidad de seguro sanitario: Mutualidades del Estado (MUFACE, ISFAS, MUGEJU) acogidas a un seguro privado                                                          |
| O84\_4        | Modalidad de seguro sanitario: Seguro médico privado, concertado individualmente (sociedades médicas, Colegios Profesionales…)                                       |
| O84\_5        | Modalidad de seguro sanitario: Seguro médico concertado por la empresa                                                                                               |
| O84\_6        | Modalidad de seguro sanitario: No tiene seguro médico                                                                                                                |
| O84\_7        | Modalidad de seguro sanitario: Otras situaciones                                                                                                                     |
| O84\_8        | Modalidad de seguro sanitario: No sabe                                                                                                                               |
| O84\_9        | Modalidad de seguro sanitario: No contesta                                                                                                                           |
| P85           | Consumo de medicamentos recetados por un médico durante las dos últimas semanas                                                                                      |
| P86           | Consumo de medicamentos no recetados por un médico durante las dos últimas semanas                                                                                   |
| P87\_1a       | Medicinas para el catarro, gripe, garganta, bronquios consumidas                                                                                                     |
| P87\_1b       | Medicinas para el catarro, gripe, garganta, bronquios recetadas                                                                                                      |
| P87\_2a       | Medicinas para el dolor consumidas                                                                                                                                   |
| P87\_2b       | Medicinas para el dolor recetadas                                                                                                                                    |
| P87\_3a       | Medicinas para bajar la fiebre consumidas                                                                                                                            |
| P87\_3b       | Medicinas para bajar la fiebre recetadas                                                                                                                             |
| P87\_4a       | Reconstituyentes como vitaminas, minerales, tónicos consumidos                                                                                                       |
| P87\_4b       | Reconstituyentes como vitaminas, minerales, tónicos recetados                                                                                                        |
| P87\_5a       | Laxantes consumidos                                                                                                                                                  |
| P87\_5b       | Laxantes recetados                                                                                                                                                   |
| P87\_6a       | Antibióticos consumidos                                                                                                                                              |
| P87\_6b       | Antibióticos recetados                                                                                                                                               |
| P87\_7a       | Tranquilizantes, relajantes, pastillas para dormir consumidos                                                                                                        |
| P87\_7b       | Tranquilizantes, relajantes, pastillas para dormir recetados                                                                                                         |
| P87\_8a       | Medicamentos para la alergia consumidos                                                                                                                              |
| P87\_8b       | Medicamentos para la alergia recetados                                                                                                                               |
| P87\_9a       | Medicamentos para la diarrea consumidos                                                                                                                              |
| P87\_9b       | Medicamentos para la diarrea recetados                                                                                                                               |
| P87\_10a      | Medicinas para el reuma consumidas                                                                                                                                   |
| P87\_10b      | Medicinas para el reuma recetadas                                                                                                                                    |
| P87\_11a      | Medicinas para el corazón consumidas                                                                                                                                 |
| P87\_11b      | Medicinas para el corazón recetadas                                                                                                                                  |
| P87\_12a      | Medicinas para la tensión arterial consumidas                                                                                                                        |
| P87\_12b      | Medicinas para la tensión arterial recetadas                                                                                                                         |
| P87\_13a      | Medicinas para el estómago y/o las alteraciones digestivas consumidas                                                                                                |
| P87\_13b      | Medicinas para el estómago y/o las alteraciones digestivas recetadas                                                                                                 |
| P87\_14a      | Antidepresivos, estimulantes consumidos                                                                                                                              |
| P87\_14b      | Antidepresivos, estimulantes recetados                                                                                                                               |
| P87\_15a      | Píldoras para no quedar embarazada consumidas                                                                                                                        |
| P87\_15b      | Píldoras para no quedar embarazada recetadas                                                                                                                         |
| P87\_16a      | Hormonas para la menopausia consumidas                                                                                                                               |
| P87\_16b      | Hormonas para la menopausia recetadas                                                                                                                                |
| P87\_17a      | Medicamentos para adelgazar consumidos                                                                                                                               |
| P87\_17b      | Medicamentos para adelgazar recetados                                                                                                                                |
| P87\_18a      | Medicamentos para bajar el colesterol consumidos                                                                                                                     |
| P87\_18b      | Medicamentos para bajar el colesterol recetados                                                                                                                      |
| P87\_19a      | Medicamentos para la diabetes consumidos                                                                                                                             |
| P87\_19b      | Medicamentos para la diabetes recetados                                                                                                                              |
| P87\_20a      | Medicamentos para el tiroides consumidos                                                                                                                             |
| P87\_20b      | Medicamentos para el tiroides recetados                                                                                                                              |
| P87\_21a      | Productos homeopáticos consumidos                                                                                                                                    |
| P87\_21b      | Productos homeopáticos recetados                                                                                                                                     |
| P87\_22a      | Productos naturistas consumidos                                                                                                                                      |
| P87\_22b      | Productos naturistas recetados                                                                                                                                       |
| P87\_23a      | Otros medicamentos consumidos                                                                                                                                        |
| P87\_23b      | Otros medicamentos recetados                                                                                                                                         |
| Q88           | Vacunación de la gripe en la última campaña                                                                                                                          |
| Q89           | Toma de tensión arterial alguna vez por un profesional sanitario                                                                                                     |
| Q90           | Tiempo que hace de la última toma de tensión arterial                                                                                                                |
| Q91           | Medición del nivel de colesterol en sangre                                                                                                                           |
| Q92           | Tiempo que hace de la última medición de colesterol                                                                                                                  |
| Q93           | Medición del nivel de azúcar en sangre por un profesional sanitario                                                                                                  |
| Q94           | Tiempo que hace de la última medición de azúcar en sangre                                                                                                            |
| Q95           | ¿Alguna vez le han hecho una prueba de sangre oculta en heces?                                                                                                       |
| Q96           | Tiempo que hace de la última prueba de sangre oculta en heces                                                                                                        |
| Q97           | Principal razón de la última prueba de sangre oculta en heces                                                                                                        |
| Q98           | ¿Le han realizado alguna vez una colonoscopia?                                                                                                                       |
| Q99           | Tiempo que hace de la última colonoscopia                                                                                                                            |
| Q100          | ¿Alguna vez le han hecho una mamografía?                                                                                                                             |
| Q101          | Tiempo que hace de la última mamografía                                                                                                                              |
| Q102          | Principal razón de la última mamografía                                                                                                                              |
| Q103          | ¿Alguna vez le han hecho una citología vaginal?                                                                                                                      |
| Q104          | Tiempo que hace de la última citología                                                                                                                               |
| Q105          | Principal razón de la última citología                                                                                                                               |
| R106          | Falta de asistencia médica debido a listas de espera en los últimos 12 meses                                                                                         |
| R107          | Falta de asistencia médica debido a problemas de transporte en los últimos 12 meses                                                                                  |
| R108\_1       | Falta de atención sanitaria debido a problemas económicos en los últimos 12 meses: Atención médica                                                                   |
| R108\_2       | Falta de atención sanitaria debido a problemas económicos en los últimos 12 meses: Atención dental                                                                   |
| R108\_3       | Falta de atención sanitaria debido a problemas económicos en los últimos 12 meses: Algún medicamento que le habían recetado                                          |
| R108\_4       | Falta de atención sanitaria debido a problemas económicos en los últimos 12 meses: Atención de salud mental                                                          |
| S109          | Altura en cm                                                                                                                                                         |
| S110          | Peso en kg                                                                                                                                                           |
| T111          | Tipo de actividad física que realiza en la actividad principal                                                                                                       |
| T112          | Frecuencia con la que realiza alguna actividad física en su tiempo libre                                                                                             |
| T113          | Últimos 7 días: Nº de días de actividades físicas intensas                                                                                                           |
| T114\_1       | Tiempo al día dedicado a actividades físicas intensas: Horas por día                                                                                                 |
| T114\_2       | Tiempo al día dedicado a actividades físicas intensas: Minutos por día                                                                                               |
| T115          | Últimos 7 días: Nº de días de actividades físicas moderadas                                                                                                          |
| T116\_1       | Tiempo al día dedicado a actividades físicas moderadas: Horas por día                                                                                                |
| T116\_2       | Tiempo al día dedicado a actividades físicas moderadas: Minutos por día                                                                                              |
| T117          | Últimos 7 días: Tiempo dedicado a caminar (por lo menos durante 10min seguidos)                                                                                      |
| T118\_1       | Últimos 7 días: Tiempo dedicado a caminar en un día normal (Horas por día)                                                                                           |
| T118\_2       | Últimos 7 días: Tiempo dedicado a caminar en un día normal (Minutos por día)                                                                                         |
| T119\_1       | Últimos 7 días: Tiempo sentado en un día normal (Horas por día)                                                                                                      |
| T119\_2       | Últimos 7 días: Tiempo sentado en un día normal (Minutos por día)                                                                                                    |
| U120\_1       | Frecuencia de consumo de fruta fresca (excluyendo zumos)                                                                                                             |
| U120\_1a      | Consumo de fruta fresca (excluyendo zumos): Cantidad                                                                                                                 |
| U120\_2       | Frecuencia de consumo de carne (pollo, ternera, cerdo, cordero, etc.)                                                                                                |
| U120\_3       | Frecuencia de consumo de huevos                                                                                                                                      |
| U120\_4       | Frecuencia de consumo de pescado                                                                                                                                     |
| U120\_5       | Frecuencia de consumo de pasta, arroz, patatas                                                                                                                       |
| U120\_6       | Frecuencia de consumo de pan, cereales                                                                                                                               |
| U120\_7       | Frecuencia de consumo de verduras, ensaladas y hortalizas                                                                                                            |
| U120\_7a      | Consumo de verduras, ensaladas y hortalizas: Cantidad                                                                                                                |
| U120\_8       | Frecuencia de consumo de legumbres                                                                                                                                   |
| U120\_9       | Frecuencia de consumo de embutidos y fiambres                                                                                                                        |
| U120\_10      | Frecuencia de consumo de productos lácteos (leche, queso, yogur)                                                                                                     |
| U120\_11      | Frecuencia de consumo de dulces (galletas, bollería, mermeladas, etc.)                                                                                               |
| U120\_12      | Frecuencia de consumo de refrescos con azúcar                                                                                                                        |
| U120\_13      | Frecuencia de consumo de comida rápida (pollo frito, bocadillos, pizzas, hamburguesas)                                                                               |
| U120\_14      | Frecuencia de consumo de aperitivos o comidas saladas de picar (patatas fritas, ganchitos, galletitas saladas)                                                       |
| U120\_15      | Frecuencia de consumo de zumo natural de frutas o verduras                                                                                                           |
| U120\_15a     | Consumo de zumo natural de frutas o verduras: Cantidad                                                                                                               |
| U120FZ        | Frecuencia diaria de consumo de fruta fresca o zumos naturales                                                                                                       |
| U120CANTFZ    | Consumo de fruta fresca o zumo natural de frutas o verduras: Cantidad                                                                                                |
| U2\_120F      | Frecuencia diaria: Cepillado de dientes                                                                                                                              |
| V121          | ¿Fuma actualmente?                                                                                                                                                   |
| V122          | Tipo de tabaco que fuma con mayor frecuencia                                                                                                                         |
| V123          | Fumadores a diario: Número de cigarrillos que fuma al día                                                                                                            |
| V124          | Fumadores a diario: Edad en que comenzó a fumar                                                                                                                      |
| V125          | Fumadores a diario: Intentos de dejar de fumar en los últimos 12 meses                                                                                               |
| V126          | Frecuencia de exposición a ambientes de humo en lugares cerrados                                                                                                     |
| W127          | Frecuencia de consumo de alcohol en los últimos 12 meses                                                                                                             |
| W128Cer       | Consumo de cerveza con alcohol                                                                                                                                       |
| W128Cer\_1    | Consumo de cerveza con alcohol: Lunes                                                                                                                                |
| W128Cer\_2    | Consumo de cerveza con alcohol: Martes                                                                                                                               |
| W128Cer\_3    | Consumo de cerveza con alcohol: Miércoles                                                                                                                            |
| W128Cer\_4    | Consumo de cerveza con alcohol: Jueves                                                                                                                               |
| W128Cer\_5    | Consumo de cerveza con alcohol: Viernes                                                                                                                              |
| W128Cer\_6    | Consumo de cerveza con alcohol: Sábado                                                                                                                               |
| W128Cer\_7    | Consumo de cerveza con alcohol: Domingo                                                                                                                              |
| W128Vin       | Consumo de vinos, cava                                                                                                                                               |
| W128Vin\_1    | Consumo de vinos, cava: Lunes                                                                                                                                        |
| W128Vin\_2    | Consumo de vinos, cava: Martes                                                                                                                                       |
| W128Vin\_3    | Consumo de vinos, cava: Miércoles                                                                                                                                    |
| W128Vin\_4    | Consumo de vinos, cava: Jueves                                                                                                                                       |
| W128Vin\_5    | Consumo de vinos, cava: Viernes                                                                                                                                      |
| W128Vin\_6    | Consumo de vinos, cava: Sábado                                                                                                                                       |
| W128Vin\_7    | Consumo de vinos, cava: Domingo                                                                                                                                      |
| W128Vermut    | Consumo de vermuts, fino, jerez                                                                                                                                      |
| W128Vermut\_1 | Consumo de vermuts, fino, jerez: Lunes                                                                                                                               |
| W128Vermut\_2 | Consumo de vermuts, fino, jerez: Martes                                                                                                                              |
| W128Vermut\_3 | Consumo de vermuts, fino, jerez: Miércoles                                                                                                                           |
| W128Vermut\_4 | Consumo de vermuts, fino, jerez: Jueves                                                                                                                              |
| W128Vermut\_5 | Consumo de vermuts, fino, jerez: Viernes                                                                                                                             |
| W128Vermut\_6 | Consumo de vermuts, fino, jerez: Sábado                                                                                                                              |
| W128Vermut\_7 | Consumo de vermuts, fino, jerez: Domingo                                                                                                                             |
| W128Lic       | Consumo de licores, anís, pacharán                                                                                                                                   |
| W128Lic\_1    | Consumo de licores, anís, pacharán: Lunes                                                                                                                            |
| W128Lic\_2    | Consumo de licores, anís, pacharán: Martes                                                                                                                           |
| W128Lic\_3    | Consumo de licores, anís, pacharán: Miércoles                                                                                                                        |
| W128Lic\_4    | Consumo de licores, anís, pacharán: Jueves                                                                                                                           |
| W128Lic\_5    | Consumo de licores, anís, pacharán: Viernes                                                                                                                          |
| W128Lic\_6    | Consumo de licores, anís, pacharán: Sábado                                                                                                                           |
| W128Lic\_7    | Consumo de licores, anís, pacharán: Domingo                                                                                                                          |
| W128Comb      | Consumo de combinados, bebidas destiladas                                                                                                                            |
| W128Comb\_1   | Consumo de combinados, bebidas destiladas: Lunes                                                                                                                     |
| W128Comb\_2   | Consumo de combinados, bebidas destiladas: Martes                                                                                                                    |
| W128Comb\_3   | Consumo de combinados, bebidas destiladas: Miércoles                                                                                                                 |
| W128Comb\_4   | Consumo de combinados, bebidas destiladas: Jueves                                                                                                                    |
| W128Comb\_5   | Consumo de combinados, bebidas destiladas: Viernes                                                                                                                   |
| W128Comb\_6   | Consumo de combinados, bebidas destiladas: Sábado                                                                                                                    |
| W128Comb\_7   | Consumo de combinados, bebidas destiladas: Domingo                                                                                                                   |
| W128Sidra     | Consumo de bebidas locales, sidra, carajillo                                                                                                                         |
| W128Sidra\_1  | Consumo de bebidas locales, sidra, carajillo: Lunes                                                                                                                  |
| W128Sidra\_2  | Consumo de bebidas locales, sidra, carajillo: Martes                                                                                                                 |
| W128Sidra\_3  | Consumo de bebidas locales, sidra, carajillo: Miércoles                                                                                                              |
| W128Sidra\_4  | Consumo de bebidas locales, sidra, carajillo: Jueves                                                                                                                 |
| W128Sidra\_5  | Consumo de bebidas locales, sidra, carajillo: Viernes                                                                                                                |
| W128Sidra\_6  | Consumo de bebidas locales, sidra, carajillo: Sábado                                                                                                                 |
| W128Sidra\_7  | Consumo de bebidas locales, sidra, carajillo: Domingo                                                                                                                |
| W129          | Frecuencia de consumo de 5-6 o más bebidas alcohólicas estándar en una misma ocasión durante los últimos 12 meses                                                    |
| X130\_1       | Situaciones de apoyo afectivo y personal en la vida diaria: Visitas de mis amigos y familiares                                                                       |
| X130\_2       | Situaciones de apoyo afectivo y personal en la vida diaria: Ayuda en asuntos relacionados con la casa                                                                |
| X130\_3       | Situaciones de apoyo afectivo y personal en la vida diaria: Elogios y reconocimientos al hacer bien el trabajo                                                       |
| X130\_4       | Situaciones de apoyo afectivo y personal en la vida diaria: Contar con personas que se preocupan de lo que le sucede                                                 |
| X130\_5       | Situaciones de apoyo afectivo y personal en la vida diaria: Recibir amor y afecto                                                                                    |
| X130\_6       | Situaciones de apoyo afectivo y personal en la vida diaria: Tener la posibilidad de hablar con alguien de sus problemas en el trabajo o en la casa                   |
| X130\_7       | Situaciones de apoyo afectivo y personal en la vida diaria: Tener la posibilidad de hablar con alguien de sus problemas personales y familiares                      |
| X130\_8       | Situaciones de apoyo afectivo y personal en la vida diaria: Tener la posibilidad de hablar con alguien de sus problemas económicos                                   |
| X130\_9       | Situaciones de apoyo afectivo y personal en la vida diaria: Recibir invitaciones para distraerse y salir con otras personas                                          |
| X130\_10      | Situaciones de apoyo afectivo y personal en la vida diaria: Recibir consejos útiles cuando le ocurre algún acontecimiento importante en su vida                      |
| X130\_11      | Situaciones de apoyo afectivo y personal en la vida diaria: Recibir ayuda cuando está enfermo en la cama                                                             |
| Y133          | Cuidado de personas mayores o de alguien que tenga una dolencia crónica al menos una vez a la semana                                                                 |
| Y134          | Cuidado de personas: Parentesco con el cuidador                                                                                                                      |
| Y135          | Cuidado de personas: Horas a la semana dedicadas en total                                                                                                            |
| FACTORADULTO  | Factor de elevación del adulto (4 decimales)                                                                                                                         |
| CLASE\_PR     | Variable derivada: Clase social basada en la ocupación de la persona de referencia                                                                                   |
| IMCa          | Variable derivada: Índice de masa corporal (IMC) del adulto                                                                                                          |
| CMD1          | Variable derivada: Consumo medio diario de alcohol semanal (lunes a domingo)                                                                                         |
| CMD2          | Variable derivada: Consumo medio diario de alcohol entre semana (lunes a jueves)                                                                                     |
| CMD3          | Variable derivada: Consumo medio diario de alcohol en fin de semana (viernes a domingo)                                                                              |
