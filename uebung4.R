library(tidyr)
library(dplyr)
library(modelr)
library(lubridate)
library(ggplot2)
library(nycflights13)
library(ggcorrplot)

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
