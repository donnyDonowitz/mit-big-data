library(tidyr)
library(tidyverse)
library(nycflights13)
library(ggcorrplot)
library(dplyr)
## 1. Welche Flugziele gibt es
## 2. Mittlere Verzögerung pro Flugziel
## 3. Zusammenhang zwischen Verzögerung und Entfernung

nycflights13::flights

## 1. 
colnames(flights)
unique(flights$dest)
length(unique(flights$dest))

## 2. 

flights %>% select(year, arr_delay, dest) %>%
  group_by(dest) %>%
  summarize(arr_delay=mean(arr_delay, na.rm=TRUE)) %>%
  arrange(desc(arr_delay))

## 3. 

flights %>% select(dep_delay, distance) %>%
  filter(dep_delay>0) %>%
  mutate(ratio=distance/dep_delay) %>%
  group_by(desc(dep_delay))

#ggplot(flights, aes(x=distance, y=dep_delay, colour=ratio)) + geom_point() + geom_smooth()
# dat.sub <- select(flights, arr_delay, distance)
# ggcorrplot(dat.sub)

dat.sub <- flights %>% select_if(is.numeric) %>% select(-year) %>% drop_na()
cor(dat.sub) %>%
  ggcorrplot()

flights %>% dplyr::select(where(is.numeric)) %>%
  drop_na() %>%
  round(cor(), 2) %>%
  ggcorrplot()



