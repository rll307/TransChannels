library(dbplyr)
library(ggplot)
library(ggridges)

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
