library(tidyr)
library(tidyverse)
library(nycflights13)
library(ggcorrplot)
library(dplyr)

nycflights13::flights

## Verspätungen pro Monat

flights %>% select(dep_delay, month) %>% na.omit() %>% ggplot(aes(x=as.factor(month), y=dep_delay)) + geom_boxplot() 

## Ausreisser visuell ignorieren

flights %>% select(dep_delay, month) %>% na.omit() %>% ggplot(aes(x=as.factor(month), y=dep_delay)) + geom_boxplot() + ylim(0, 100)

## Durschschnittliche Verspätung pro Monat

flights %>% select(dep_delay, month) %>% na.omit() %>% group_by(month) %>% summarize(delay=mean(dep_delay))

## Durschschnittliche Verspätung pro Monat, berückscihtigung der Abflugsverspätung

flights %>% select(arr_delay, dep_delay, month) %>% na.omit() %>% group_by(month) %>% summarize(depmean=mean(dep_delay), arrmean=mean(arr_delay))

## correlation dazwischen

cor(flights %>% select(arr_delay, dep_delay, month) %>% na.omit() %>% group_by(month) %>% summarize(depmean=mean(dep_delay), arrmean=mean(arr_delay)))

## und plotten

ggcorrplot(cor(flights %>% select(arr_delay, dep_delay, month) %>% na.omit() %>% group_by(month) %>% summarize(depmean=mean(dep_delay), arrmean=mean(arr_delay))))

## correlation von Fluglänge zu departure delay - arrival
# je länger die Flugzeit, desto höher die Warhscheinlichkeit, etwas von der Verspätung leicht aufzuholen

sub.dat <- flights %>% select(dep_delay, arr_delay, distance)  %>% na.omit()  %>% mutate(delay_diff=dep_delay-arr_delay) %>% group_by(distance) %>% sample_frac(0.1)
cor(select(sub.dat, distance, delay_diff))
ggcorrplot(cor(select(sub.dat, distance, delay_diff)))

ggplot(sub.dat, aes(x=distance, y=delay_diff)) + geom_point() + geom_smooth()
