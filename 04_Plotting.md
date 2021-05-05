# Plotting

# Introduction

This script was developed for the analysis of Portuguese. I hope it
helps colleagues in the LC area and popularize the use of R. It is part
of our research project developed with CNPQ. Please drop me a line if
you have any doubts or need any help.

# Purpose of this repository

This git brings the scripts for my article:

-   Lima-Lopes R.E. (forthcoming). Beyond the Binary: Trans Women’s
    Video Activism on YouTube. Accepted for publication at *Digital
    Scholarship in the Humanities*.

This script is specifically about **plotting**.

# Packages

For data processing we are going to need some packages:

``` r
library(dbplyr)
library(ggplot)
library(ggridges)
```

# Plotting

Definig the color and ploting graph 1

``` r
colour <-"bisque4"
df_topics  %>% 
  count(topic) %>% 
  mutate(topic = forcats::fct_reorder(topic, n)) %>% 
  ggplot(aes(x = topic, y = n)) + 
  geom_col(fill = colour) +
  theme_minimal() + 
  labs(x = "Topics", y = "Videos",
       title = NULL) +
  coord_flip()
```

Definig the color and ploting graph 2

``` r
df_topics$channel <-as.factor(df_topics$channel)
df_topics$topic <- as.factor(df_topics$topic)

xtabs(~ channel + topic, df_topics) %>% 
  as.data.frame() %>% 
  ggplot(aes(channel, topic)) + 
  geom_tile(aes(fill = Freq)) +
  scale_fill_gradient(low="#D6D2C4", high="#575257")+
  geom_text(aes(label = round(Freq, 1))) +
  labs(x = "Channels", y = "Topics",
       title = NULL)
```
