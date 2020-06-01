library(dplyr)
library(ggplot2)

read.csv('/Users/martinvazquez/Spring2020/DSC_341/datasets/auto-mpg.data')
#this didn't work in class for some reason.... so

library(nycflights13)
set.seed(123)
#SCATTERPLOTS
ggplot(flights, aes(x = dep_time, y = arr_time)) + geom_point()
#this took forever because of the size of the dataset. you should sample it in order to have quicker
#calculations and a more descriptive plot
flights_small = sample_n(flights, 2000)

ggplot(flights_small, aes(x=dep_time, y=arr_time)) + geom_point()

ggplot(flights_small, aes(x=dep_delay, y=arr_delay, col=factor(month)) ) + geom_point()
#here, every month is assigned a different color point. you can draw trends here too.
#month is a categorical variable, so it makes sense to convert it into a factor, but you can color by other variables too
#even if they are not categorical. this will make it a color scale as opposed to the number of different colors that there
#are on this plot

#HISTOGRAM
ggplot(flights_small, aes(x=dep_delay)) + geom_histogram()
ggplot(flights_small, aes(x=dep_delay)) + geom_histogram(bins=50)
#changing the number of bins is exaclty what it means

