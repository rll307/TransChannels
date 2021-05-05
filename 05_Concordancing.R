library(quanteda)

corpus.caption <- corpus(df_topics, 
                         text_field = "caption", metacorpus = NULL, 
                         compress = FALSE)

kwic(corpus.caption, pattern = "amiga", 
     window =6, valuetype = "fix")

