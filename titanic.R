library(tidyr)
library(dplyr)
library(modelr)
library(lubridate)
library(ggplot2)
library(nycflights13)
library(ggcorrplot)

trains <- read.csv("./train.csv")
trains

ggplot(trains, aes(x=PassengerId, y=Age, color=Sex)) + geom_point()

dat <- trains %>% select_if(is.numeric) %>% drop_na()

cor(dat)
ggcorrplot(dat)
