library(dplyr)
library(ggplot2)
install.packages('tidyverse')
library(tidyverse)
auto = read.table('/Users/martinvazquez/Spring2020/DSC_341/datasets/auto-mpg.data')
names = c('mpg', 'cylinders', 'displacement', 'horsepower', 'weight', 'acceleration', 'model_year', 'origin', 'car_name')
colnames(auto) = names
colnames(auto)

#begin doing stuff with the data
str(auto)
summary(auto)

df = mutate(auto, horsepower2 = ifelse(horsepower == '?', NA, as.character(horsepower)))
auto$horsepower = as.numeric(df$horsepower2)
str(auto)
auto = auto %>% mutate(cylinders = as.factor(cylinders), origin = as.factor(origin))

#impute the missing values
df = drop_na(auto) #uses tidyverse library

install.packages('mice')
library(mice)

md.pattern(auto) #to visualize the 
micemod = mice(data=auto, m=2) #predicting the missing value based on values in its row
miceoutput = complete(micemod)

anyNA((miceoutput))
anyNA(auto)

auto = miceoutput

#scatterplot
ggplot(auto, aes(x=horsepower, y=mpg)) + geom_point()
ggplot(auto, aes(x=cylinders, y=horsepower)) + geom_jitter() #jitter adds randomness in the axis of the categorical variable
ggplot(auto, aes(x=horsepower, y=mpg, color=cylinders)) + geom_point()
ggplot(auto, aes(x=horsepower, y=mpg, color=model_year)) + geom_point() #numeric value is continuous. 
#create scatterplot of mpg vs weight, color by origin
ggplot(auto, aes(x = weight, y=mpg, color=origin))+ geom_point()
#mean mpg each year
auto_year = auto %>% group_by(model_year) %>% summarize(mean_mpg = mean(mpg))
ggplot(auto_year, aes(x=model_year, y=mean_mpg)) + geom_line(size=2)
#mean mpg of each year and origin
auto_year_orig = auto %>% group_by(model_year, origin) %>% summarize(mean_mpg = mean(mpg))
auto_year_orig
#each origin gets their own colored line
ggplot(auto_year_orig, aes(x=model_year, y=mean_mpg, color=origin)) + geom_line(size=1)


auto_year = auto %>% group_by(model_year) %>% summarize(mean_mpg = mean(mpg),
                                                        mean_weight = mean(weight),
                                                        mean_hp = mean(horsepower))

#bar chart
ggplot(auto_year, aes(x=model_year, y=mean_mpg)) + geom_col()
ggplot(auto_year, aes(x=model_year, y=mean_weight)) + geom_col()

ggplot(auto_year, aes(x=model_year, y=mean_mpg, fill=model_year)) + geom_col()
ggplot(auto_year, aes(x=model_year, y=mean_mpg, fill=as.factor(model_year))) + geom_col()

#count plot
ggplot(auto, aes(x=origin)) + geom_bar()
ggplot(auto, aes(x=model_year, fill=origin)) + geom_bar() #stacked bar plot
ggplot(auto, aes(x=model_year, fill=origin)) + geom_bar(position='dodge')

#histogram
ggplot(auto, aes(x=mpg)) + geom_histogram()
ggplot(auto, aes(x=mpg)) + geom_histogram(binwidth=4)
ggplot(auto, aes(x=mpg, fill=origin)) + geom_histogram(binwidth=4)

#boxplot
ggplot(auto, aes(y =weight)) + geom_boxplot() + scale_x_discrete('')
ggplot(auto, aes(x=origin, y =weight)) + geom_boxplot() + scale_x_discrete('')
       