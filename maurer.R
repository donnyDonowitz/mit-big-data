library(tidyr)
library(dplyr)
library(modelr)
library(lubridate)
library(ggplot2)
library(nycflights13)
library(ggcorrplot)

print(7+2)
print("Sepp")

a <- 1
b <- a*3
print(b)

addiere_eins <- function(a, d) {
  b <- a + d
  
  return(b)
}

b <- addiere_eins(5, 2)

## Operationen werden vektorisiert
b <- c(1,2,3)
b+1

b*2+1

## Data Frames beinhalten Daten
mpg
print(mpg)

ggplot(mpg, aes(x=displ, y=hwy, colour=class)) + geom_point(size=2) 

colnames(mpg)
unique(mpg$class)

nycflights13::flights

## Verb filter
## Filter wendet logische Operationen auf Datensatz an
filter(flights, arr_delay>120 & dep_delay>120)

## Dimension, Anzahl Spalten, Anzahl Zeilen
dim(flights)
ncol(flights)
nrow(flights)

nrow(filter(flights, arr_delay>120 & dep_delay>120))

## arrange
arrange(flights, dep_delay)
arrange(flights, desc(dep_delay))
arrange(flights, desc(dep_delay), carrier)

## Verb select
select(flights, year, dep_delay, carrier)
dat.sub  <- select(flights, distance, air_time)

## Verb mutate
mutate(dat.sub, airspeed=distance/air_time)

## Verb summarise
summarise(flights, delay=mean(dep_delay))
summarise(flights, delay=mean(dep_delay, na.rm=TRUE))

## Pipeline
summarise(select(flights, year, dep_delay, carrier),
          delay=mean(dep_delay, na.rm=TRUE))

flights %>% select(year, dep_delay, carrier) %>%
  summarise(delay=mean(dep_delay, na.rm=TRUE))

## Gruppierung
flights %>% select(year, dep_delay, carrier) %>%
  group_by(carrier) %>%
  summarise(delay=mean(dep_delay, na.rm=TRUE)) %>%
  arrange(desc(delay))


## mpg abhaengig von Baujahr
## mpg ueber Zylinderanzahl
## Korrelation zwischen Daten (OK)


## Departure delay abhaengig von Flughafen
## Top-Destinationen abhaengig von Startort
## NA-Handling (+subsetting) (OK)

head(flights)

unique(flights$dest)

length(unique(flights$dest))

flights %>% group_by(dest) %>% summarise(delay=mean(arr_delay, na.rm=TRUE))

flights %>% select(arr_delay, distance) %>% 
  ggplot(aes(x=arr_delay, y=distance)) + geom_point()


corr <- round(cor(mtcars), 2)
ggcorrplot(corr)

View(table1)
View(table4a)

## Verb pivot_longer
# argument c macht einen Vektor aus den angegebenen Spalten

tab1 <- table4a %>% pivot_longer(c("1999", "2000"), names_to="year", values_to="cases")
tab2 <- table4a %>% pivot_longer(c("1999", "2000"), names_to="year", values_to="population")

## Join 
left_join(tab1, tab2)

table2

## verb pivot_wider
# pivot wider macht mehr spalten. names_from möchte wissen, wie diese Spalten heißen sollen
# und values_from, welche Daten darin stehen sollen
table2 %>% pivot_wider(names_from=type, values_from=count)

## verb separate
table3 %>% separate(rate, into=(c("cases", "population")))

## verb unite
table5 %>% unite(nyear, century, year, sep = "") %>% separate(rate, into=(c("cases", "population")))
table5 %>% unite(nyear, c("century", "year"), sep = "") %>% separate(rate, into=(c("cases", "population")))
