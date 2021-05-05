#-------------Packages-------------
library(abjutils)
library(tidytext)
library(tidyverse)
library(magrittr)
library(stm)
library(tm)
library(ggridges)
library(formattable)

#------------- General Data frame ------------- 
channel1 <- rep("channel1", 140)
df.channel1 <-cbind(df.channel1,channel1)
colnames(df.channel1)[colnames(df.channel1)=="channel1"] <- "Channel"
df.final.all <-rbind(df.channel1,df.channel2,df.channel3,df.channel4)
 
#------------- General wordlist ------------- 
df.final.all  %>% 
  unnest_tokens(word, caption) %>% 
  # filtering stopwords
  filter(!word %in% sw_pt_tm)%>%
  # Counting
  count(word) %>% 
  arrange(desc(n)) %>% 
  formattable()

#-------------  stopwords list ------------- 
sw_pt_tm <- tm::stopwords("pt")
sw_pt_tm <- rm_accent(sw_pt_tm)

#------------- Processing the topics ------------- 
#
proc <- stm::textProcessor(df.final.all$caption, metadata = df.final.all, 
                           language = "portuguese",
                           customstopwords = sw_pt_tm)
out <- stm::prepDocuments(proc$documents, proc$vocab, proc$meta,
                          lower.thresh = 10)

storage <- stm::searchK(out$documents, out$vocab, K = c(3:15),
                        data = out$meta)

fit <- stm::stm(
  documents = out$documents, vocab = out$vocab, data = out$meta,  K = 4,
  max.em.its = 75, init.type = "Spectral", verbose = FALSE
)
#------------- Common words ------------- 
#
## More common words in each topic
stm::labelTopics(fit)
#plot(fit, "summary")
plot(fit$theta, type = "p", col="blue")
head(fit$theta)
view(fit$theta)

#------------- Topic names ------------- 
#
Topic.Names <- c("Relationships",
                 "Gender",
                 "Beauty", 
                 "Transition")

#------------- Video possibility ------------- 
prob <- apply(fit$theta, 1, max)

#Possibility for each topic
Videos.Topic <- Topic.Names[apply(fit$theta, 1, which.max)]

#Join
df_topics <- df.final.all %>% 
  mutate(best_prob = prob,
         topic = Videos.Topic)








