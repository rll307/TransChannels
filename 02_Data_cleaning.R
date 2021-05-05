

## ----packages, eval=FALSE---------------------------------------
library(abjutils)
library(tidytext)
library(reticulate)
reticulate::use_python("<your Python instalation>", required = TRUE)
library(tidyverse)
library(magrittr)
library(stm)
library(tm)
library(ggridges)
library(formattable)
options(scipen = 999)
## 


## ----informing, eval=FALSE--------------------------------------
My.Caption.Files <- dir(Captions.Folder, pattern = '*.vtt', full.names = TRUE)
source_python("caption_to_vector.py") # Importing Python script


## ----f1, eval=FALSE---------------------------------------------
Cleaning.Captions <- function(file){ #Defines the variable
  # Imports Python script into the function
  caption_raw <- caption_to_vector(file) 
  # Tells us the number of lines
  n <- length(caption_raw) #
  # Removes \n from all lines but the last
  caption <- c(stringr::str_remove_all(caption_raw[-n], "[\n].*"),
               caption_raw[n])
  # Removes duplicated lines
  caption <- unique(caption)
  # Removes diacritical marks (remeber that Portuguese has a number of them)
  caption <- rm_accent(caption)
  # Merges them
  caption <- paste0(caption, collapse = "\n")
  caption
}


## ----f2, eval=FALSE---------------------------------------------
Metadata.Extract <- function(file, folder = Captions.Folder,
                             fields = basic.fields){
  mat <- str_split(file, "&{3}", simplify = TRUE)
  mat[1,1] <- mat[1,1] %>% str_remove_all(Captions.Folder) %>% str_remove_all("/")
  cols <- fields[1:ncol(mat)]
  colnames(mat) <- cols
  as.tibble(mat)
}

## ----f3, eval=FALSE---------------------------------------------
caption_to_df <- function(file, ...){
  caption <- Cleaning.Captions(file)
  meta <- Metadata.Extract(file, ...)
  meta <- meta %>% mutate(caption = caption)
  meta
}


## ----cleaning, eval=FALSE---------------------------------------
df.final <- My.Caption.Files %>% 
  map_df(caption_to_df) %>% 
  # converte the class of some columns
  mutate(upload_date = lubridate::ymd(upload_date)) %>% 
  mutate_at(vars(duration:dislike_count), as.numeric)

