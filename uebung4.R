library(tidyr)
library(dplyr)
library(modelr)
library(lubridate)
library(ggplot2)
library(nycflights13)
library(ggcorrplot)
library("GGally")


dat <- read.csv("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/4_ThreeNum.csv")
dat

ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop)) + geom_point()
ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop)) + geom_point() + geom_smooth()
ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point()


## Transformationen: sclae_*_continuous, scale_*_log10, , scale_*_sqrt
ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point() + scale_x_sqrt()
ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point() + scale_x_log10()


## facettierung: facet_grid und facet_wrap

ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point() + facet_grid(cols = vars(continent))
ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point() + facet_wrap(facets = vars(continent))

## Visuelle Details
# xlab, ylab

ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point() + xlab("BIP pro Kopf") + ylab("Lebenserwartung")

## Visuelle Details
## scale_*_manuel

ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point() + scale_color_manual(values=c("green", "red", "blue", "black", "white"))

## Themes
# theme_*(bw, light)
ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point() + theme_bw()
ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point() + theme_light()
ggplot(dat, aes(x=gdpPercap, y=lifeExp, size=pop, colour=continent)) + geom_point() + theme_dark()


## Arbeiten mit Time Series Daten
today() # Tag 
now() # Tag und Uhrzeit
class(now())
ymd("2021-08-09") # übersetzen in Datumsobjekt
as.integer(ymd("2021-08-09") - ymd("2021-07-16"))
mdy("02-19-1998")
ymd_hms("2023-10-08 12:12:52", tz="CET")

timestamp("12:12:00")



## Fligths Datensatz: Datumsangabe über mehrere Spalten verteilt
# diese vereinheitlichen zu einem Datum
flights %>% select(year, month, day, hour, minute)
flights %>% mutate(timestamp=make_datetime(year, month, day, hour, minute, tz="EST")) %>% select(timestamp, carrier, flight, origin, dest)
dat <- flights %>% mutate(date=make_datetime(year, month, day)) %>% mutate(time=timestamp(hour, minute)) %>% sample_frac(0.1)
dat2 <- flights %>% mutate(timestamp=make_datetime(year, month, day, hour, minute, tz="EST")) %>% mutate(week=week(timestamp)) %>% select(timestamp, starts_with("arr"), starts_with("dep"), day) %>% sample_frac(0.05)
dat3 <- dat2 %>% filter(timestamp <= ymd("2013-01-08")) 

wday(today())
week(today())

ggplot(dat2, aes(x=timestamp, y=arr_delay)) + geom_smooth() + facet_grid(cols=vars("week"))
ggplot(dat3, aes(x=timestamp, y=arr_delay)) + geom_smooth()

ggplot(dat3, aes(x=timestamp)) + geom_freqpoly(bins=5)

ggplot(dat3, aes(x=timestamp, y=arr_delay)) + geom_point() + facet_grid(cols=vars("day"))

ggplot(dat3, aes(x=timestamp, y=arr_delay)) + geom_point() + facet_grid(cols=wday(timestamp))

dat3 %>% mutate(wday=wday(timestamp, label=TRUE)) %>% ggplot(aes(x=timestamp, y=arr_delay)) + geom_line() + facet_grid(cols=vars(wday), scales="free_x")


## data frames immer zuerst in tibble konvertieren
df <- read.csv("./dataset.csv")
ggp <- ggpairs(df)

df.tib <- as_tibble(df)
df[,1,2]
class(df)
class(df[,1,2])
class(df.tib)

## plots speichern

ggsave("./plot.pdf", ggp)

## konertieren in knitr damit Code und Dokumentation gemeinsam verwendet werden können