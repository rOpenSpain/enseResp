# Filter survey data by variable type

Returns a subset of columns from a survey dataset that belong to a given
thematic category, as defined in the accompanying `*_info` dataset.
Identifier columns (`CCAA` and `IDENTHOGAR`) are always included when
present.

## Usage

``` r
get_variable(df, info, type)
```

## Arguments

- df:

  A data frame. One of the main survey datasets (`adults_19`,
  `children_19`, `household_19`, etc.).

- info:

  A data frame. The corresponding `*_info` dataset (`adults_19_info`,
  `children_19_info`, etc.). Must contain columns `variable_ine` and
  `tipo_variable`.

- type:

  Character string. The variable category to select. Use
  `unique(info$tipo_variable)` to list available types.

## Value

A data frame with identifier columns plus all variables belonging to
`type`.

## Examples

``` r
# See available types
unique(adults_19_info$tipo_variable)
#>  [1] NA                                                                           
#>  [2] "IDENTIFICACIÓN DEL PROXY"                                                   
#>  [3] "E. CARACTERÍSTICAS DEMOGRÁFICAS DE LA PERSONA ADULTA SELECCIONADA"          
#>  [4] "F. RELACIÓN DE LA PERSONA ADULTA SELECCIONADA CON LA ACTIVIDAD ECONÓMICA"   
#>  [5] "G. ESTADO DE SALUD"                                                         
#>  [6] "H. ACCIDENTALIDAD"                                                          
#>  [7] "I. RESTRICCIÓN DE LA ACTIVIDAD"                                             
#>  [8] "K. LIMITACIONES, FÍSICAS , SENSORIALES Y COGNITIVAS"                        
#>  [9] "L. LIMITACIONES PARA LA REALIZACIÓN DE LAS ACTIVIDADES DE LA VIDA COTIDIANA"
#> [10] "M. SALUD MENTAL"                                                            
#> [11] "N. CONSULTAS MÉDICAS Y OTROS SERVICIOS AMBULATORIOS"                        
#> [12] "O. HOSPITALIZACIONES, URGENCIAS Y SEGURO SANITARIO"                         
#> [13] "P. CONSUMO DE MEDICAMENTOS"                                                 
#> [14] "Q. PRÁCTICAS PREVENTIVAS"                                                   
#> [15] "R. NECESIDADES DE ATENCIÓN MÉDICA NO CUBIERTAS"                             
#> [16] "S. CARACTERÍSTICAS FÍSICAS"                                                 
#> [17] "T. ACTIVIDAD FÍSICA"                                                        
#> [18] "U. ALIMENTACIÓN"                                                            
#> [19] "U2. HIGIENE DENTAL"                                                         
#> [20] "V. CONSUMO DE TABACO Y EXPOSICIÓN AL HUMO DE TABACO"                        
#> [21] "W. CONSUMO DE ALCOHOL"                                                      
#> [22] "X. APOYO AFECTIVO Y PERSONAL"                                               
#> [23] "Y. CUIDADO A OTRAS PERSONAS CON PROBLEMAS DE SALUD"                         
#> [24] "OTRAS VARIABLES"                                                            

# Filter to health status variables
get_variable(adults_19, adults_19_info, "G. ESTADO DE SALUD")
#> # A tibble: 23,089 × 102
#>    CCAA  IDENTHOGAR   G21   G22   G23   G24 G25a_1 G25b_1 G25c_1 G25a_2 G25b_2
#>    <chr> <chr>      <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
#>  1 16    00001011       3     1     2     1      1      1      1      2     NA
#>  2 16    00001021       2     2     3    NA      2     NA     NA      2     NA
#>  3 16    00001041       4     1     2     1      2     NA     NA      2     NA
#>  4 16    00001051       2     1     3    NA      2     NA     NA      2     NA
#>  5 16    00001071       2     1     3    NA      1      1      1      2     NA
#>  6 16    00001091       2     1     3    NA      2     NA     NA      2     NA
#>  7 16    00001101       3     1     3    NA      2     NA     NA      2     NA
#>  8 16    00001131       2     2     3    NA      2     NA     NA      2     NA
#>  9 16    00001151       2     2     3    NA      2     NA     NA      2     NA
#> 10 16    00002011       3     1     2     1      2     NA     NA      2     NA
#> # ℹ 23,079 more rows
#> # ℹ 91 more variables: G25c_2 <dbl>, G25a_3 <dbl>, G25b_3 <dbl>, G25c_3 <dbl>,
#> #   G25a_4 <dbl>, G25b_4 <dbl>, G25c_4 <dbl>, G25a_5 <dbl>, G25b_5 <dbl>,
#> #   G25c_5 <dbl>, G25a_6 <dbl>, G25b_6 <dbl>, G25c_6 <dbl>, G25a_7 <dbl>,
#> #   G25b_7 <dbl>, G25c_7 <dbl>, G25a_8 <dbl>, G25b_8 <dbl>, G25c_8 <dbl>,
#> #   G25a_9 <dbl>, G25b_9 <dbl>, G25c_9 <dbl>, G25a_10 <dbl>, G25b_10 <dbl>,
#> #   G25c_10 <dbl>, G25a_11 <dbl>, G25b_11 <dbl>, G25c_11 <dbl>, …
```
