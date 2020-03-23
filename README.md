
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

## Example

This is a basic example which shows you how to solve a common problem:

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

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub\!
