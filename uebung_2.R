library(ggcorrplot)

install.packages("ggcorrplot")

corr <- round(cor(mtcars), 1)
ggcorrplot(corr)



library(nycflights13)

nycflights13::flights
print(flights)


flights %>% select(dep_time, sched_dep, dep_delay, sched_arr_time, arr_delay, air_time, distance) %>% ggcorrplot()
