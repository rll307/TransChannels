# Introduction

This script was developed for the analysis of Portuguese. I hope it
helps colleagues in the LC area and popularize the use of R. It is part
of our research project developed with CNPQ. Please drop me a line if
you have any doubts or need any help.

# Purpose of this repository

This git brings the scripts for my article:

-   Rodrigo Esteves de Lima Lopes, Beyond the binary: Trans women’s video activism on YouTube, Digital Scholarship in the Humanities, Volume 37, Issue 1, April 2022, Pages 67–80, [https://doi.org/10.1093/llc/fqab057](https://doi.org/10.1093/llc/fqab057)

This script is specifically about **Concordancing**.

# Package

For concordancing we will need only one package

``` r
library(quanteda)
```

Creating the corpus

``` r
corpus.caption <- corpus(df_topics, 
                     text_field = "caption", metacorpus = NULL, 
                     compress = FALSE)
```

Please, change the variable `pattern` for the word of your interest and
`window` for the number of words (left and right)

``` r
kwic(corpus.caption, pattern = "amiga", 
                  window =6, valuetype = "fix")
```
