library(tidyr)
library(dplyr)
library(modelr)
library(lubridate)
library(ggplot2)
library(nycflights13)
library(ggcorrplot)

dat <- tibble(x=seq(0, 100, length.out=n), y=0,1*x+sin(0.25*x)+rnorm(100, sd=0.5))
dat2 <- tibble(x=seq(0, 100, length.out=n), y=0.1 * x + sin(0.25*x))

n <- 200
tibble(x=seq(0,100,length.out=n), y=0.1*x+rnorm(n, sd = 3))
tibble(x=seq(0,100,length.out=n), y=0.1*x+rnorm(n, sd = 0.5)) %>% ggplot(aes(x=x, y=y)) + geom_point()
tibble(x=seq(0, 100, length.out=n), y=0.1 * x + sin(0.25*x)) %>% ggplot(aes(x=x, y=y)) + geom_point()
tibble(x=seq(0,100,length.out=n), y=0.1*x+rnorm(n, sd = 3)) %>% ggplot(aes(x=x, y=y)) + geom_point()

dat <- tibble(x=seq(0,100,length.out=n), y=0.1*x+sin(0.25*x)+rnorm(100, sd=0.5))
plot(dat)
# lm = lineares Modell
lm(y~x, data=dat)

lm(y~x, data=dat2)

summary(lm(y~x, data=dat))

plot(lm(y~x, data=dat))
plot(lm(y~x, data=dat2))

n <- 200

dat3 <- tibble(x=seq(0, 100, length.out=n), y=8.888*x+sin(0.5*x)) # +rnorm(n/2, sd=3))
ggplot(dat3, aes(x=x, y=y)) + geom_point()
lm(y~x, data=dat3)
summary(lm(y~x, data=dat3))
plot(lm(y~x, data=dat3))


## Uebung zur Informationsvisualisierung
# zufällige vertielung von punkten
# gruppieren in vierecke und kreise
# farben mit einbringen

# zufallsdaten
rnorm(200, sd=4)

colors = c("darkred", "darkblue")
colors <- colors[as.numeric(unlist(dat2))]

shapes = c(16, 15)
shapes <- shapes[as.numeric(unlist(dat2))]
plot(dat2)
dat2
plot(dat2, pch=shapes, col=colors, xlab="X-Achse", ylab="Y-Achse", main="Farbplot")
legend("bottomright", c("Roter Kreis", "Blaues Viereck"), pch=c(16,15), col=c("darkred", "darkblue"))

dat4 <- tibble(x=runif(40), y=runif(40), colour = "red")
dat4[sample(1:40, 1),]$colour = "blue"
  
ggplot(dat4, aes(x=x, y=y, colour=colour)) + geom_point(size=5, colour=dat4$colour)
plot(dat2, pch=shapes, col=colors, xlab="X-Achse", ylab="Y-Achse", main="Farbplot")
legend("bottomright", c("Roter Kreis", "Blaues Viereck"), pch=c(16,15), col=c("darkred", "darkblue"))

xx <- c(1, 2, 3, 3, 4, 5)
yy <- c(1.4, 1.5, 1.2, 1.5, 1.5, 1.4)

dat5 = tibble(x=xx, y=yy, colour = "black")
dat5[3,3] = "white"
ggplot(dat5, aes(x=x, y=y, colour=colour)) + geom_point(size=25, colour=dat5$colour)

              