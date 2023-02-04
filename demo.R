library(tidyverse)

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
b <- c(1,2,3)
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
ggplot(mpg, aes(x=displ, y=hwy, colour=class)) + geom_point() + geom_smooth()