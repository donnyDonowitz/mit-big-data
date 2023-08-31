## ----echo=FALSE, message=FALSE------------------------------------------------
library(tidyr)
library(ggplot2)
library(dplyr)
library(lubridate)
library(nycflights13)

dat <- flights %>% mutate(timestamp=make_datetime(year, month, day, hour, minute, tz="EST")) %>% 
                   select(timestamp, starts_with("dep"), starts_with("arr"))

## ----echo=FALSE, message=FALSE------------------------------------------------
  dat %>% filter(timestamp <= ymd(20130108)) %>% 
   mutate(wday=wday(timestamp, label=TRUE)) %>%
   ggplot(aes(x=timestamp, y=dep_delay)) + geom_line() + 
   facet_grid(cols=vars(wday), scale="free_x")

