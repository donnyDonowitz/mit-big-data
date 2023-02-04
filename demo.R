library(tidyverse)
library(nycflights13)

print("moinsn")

a <- 1
b <- a*3
print(b)

add_one <- function(a, b) {
  d <- a + b
  
  return(d)
}

c <- add_one(5,7)
print(c)

## Operationen werden vektorisiert
b <- c(1, 2, 3)
b+1
 
b*2+1

## Data Frames beinhalten Daten
## mpg = miles per gallon
print(mpg)
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point() + geom_smooth()

colnames(mpg)
summary(mpg$class)
unique(mpg$class)

## Zusatzeigenschft in den Plot einbauen 'Fahrzeugklasse'
ggplot(mpg, aes(x=displ, y=hwy, colour=class)) + geom_point()

## filter Baz

nycflights13::flights
filter(flights, month==1)
#filter(flights, month %in% c(9,11,12))
filter(flights, (arr_delay>120 & dep_delay>120))

## größe herausfinden
# dimension Zeilen X Spalten
dim(flights)
# anzahl spalten
ncol(flights)
# anzahl spalten
nrow(flights)

nrow(filter(flights, (arr_delay>120 & dep_delay>120)))

## arrange

arrange(flights, dep_delay)
arrange(flights, desc(dep_delay))
arrange(flights, desc(dep_delay), carrier)

## select
# nur bestimmte Spalten betrachten
select(flights, year, dep_delay, carrier)
select(flights, distance, air_time)

# sub datensatz
dat.sub <- select(flights, distance, air_time)

## mutate
# ableitungen erstellen, fügt zusätzliche Spalten hinzu

# meilen pro minute
mutate(dat.sub, airspeed=distance/air_time)

# in km/h
# 1,609 KM = 1 mile
mutate(dat.sub, distance_km=1.609*distance, air_time_h=air_time/60, kmh=distance_km/air_time_h)

## summarize
# mittlere verspätung
summarize(flights, mean(dep_delay))
# PROBLEM: gibt anscheinend mind. ein Datum dazu nicht, deshalb Fehler: NA
# mit na.rm berechnet man ihn für alle vorhandenden Werte
summarize(flights, mean(dep_delay, na.rm=TRUE))

## Pipeliens

summarize(select(flights, year, dep_delay, carrier), dep_delay=mean(dep_delay, na.rm=TRUE))

# viele geschachtelte Ausdrücke können einfacher über pipes arrangiert werden

flights %>% select(year, dep_delay, carrier) %>%
  summarize(dep_delay=mean(dep_delay, na.rm=TRUE))

## group_by Gruppierung

# mittlere verspätung nach Fluglinie

flights %>% select(year, dep_delay, carrier) %>%
  group_by(carrier) %>%
  summarize(dep_delay=mean(dep_delay, na.rm=TRUE)) %>%
  arrange(desc(dep_delay))
