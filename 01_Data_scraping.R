

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


## ----fields, eval=FALSE-----------------------------------------
basic.fields <- c("id", "title", "alt_title", "creator", "release_date",
                 "timestamp", "upload_date", "duration", "view_count",
                 "like_count", "dislike_count", "comment_count")


## ----fieldsb, eval=FALSE----------------------------------------
fields <- basic.fields %>%
  map_chr(~paste0("%(", ., ")s")) %>%
  # use &&& as fiels separator
  paste0(collapse = "&&&") %>%
   # add quotes in the beging and end of each stream
  paste0('"', ., '"')


## ----url, eval=FALSE--------------------------------------------
 url <- "<your channel or video URL>"


## ----query, eval=FALSE------------------------------------------
 cmd_raw <- str_glue("youtube-dl -o {fields} -i -v -w --skip-download --write-auto-sub --sub-lang pt --sub-format vtt {url}")


## ----cmd1, eval=FALSE-------------------------------------------
Captions.Folder <- "<path to the folder>" # Informs the folder location
fs::dir_create(Captions.Folder) # Creates the folder
download.captions <- str_glue("cd {Captions.Folder} && {cmd_raw}") # Creates the actual command


## ----cmd2, eval=FALSE-------------------------------------------
system(download.captions)

