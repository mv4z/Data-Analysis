library(tidyverse)
install.packages('openintro')
library(openintro)

#CALCULATING CORRELATION (r)
x = c(3,4,5,6,7)
y = c(10,9,12,15,13)
cor(x, y)
xmean = mean(x)
ymean = mean(y)
seq(5)
numerator = 0
for (index in seq(5)){
  numerator <- numerator + (x[index] - xmean) * (y[index]-ymean)
  print(numerator)
  }
x_sum = 0
y_sum = 0
for(index in seq(5)){
  x_sum <- x_sum + (x[index] - xmean)^2
  y_sum <- y_sum + (y[index] - ymean)^2
}
x_sum
y_sum
denominator <- sqrt(x_sum * y_sum)
numerator/denominator 

#outliers
data(bdims)
ggplot(bdims, aes(x=hgt, y=wgt, color=factor(sex))) + geom_point()
#linear regression (linear model) formula is in (independent ~ dependent)
lm(formula = wgt~hgt, data = bdims)
ggplot(bdims, aes(x=hgt, y=wgt, color=factor(sex))) + geom_point() + stat_smooth(method='lm')
set.seed(123)
#creating outliers in the data
bdims2 <- bdims %>% 
  mutate(hgt_outlier = ifelse(hgt > 195, hgt*2, hgt))
summary(bdims2)
#linear regression with teh outlier data
lm(formula = wgt ~ hgt_outlier, data = bdims2)
ggplot(bdims2, aes(x=hgt_outlier, y=wgt)) + geom_point() + stat_smooth(method = 'lm')

ggplot(bdims2, aes( x =hgt_outlier)) + geom_boxplot()
quantile(bdims2$hgt_outlier)
iqr = IQR(bdims2$hgt_outlier)
bdims3 = filter(bdims2, hgt_outlier < 200 + 1.5*iqr)
ggplot(bdims3, aes(x=hgt_outlier, y=wgt)) + geom_point()
ggplot(bdims3, aes(x=hgt_outlier)) + geom_boxplot()

#capping
x = bdims2$hgt_outlier
qnt = quantile(x, probs=c(.25,.75), na.rm=T)
caps= quantile(x, c(.05, .95), na.rm=T)

H = 1.5 * IQR(x, na.rm=T)
x[x < (qnt[1] - H)] = caps[1]
x[x > (qnt[2] + H)] = caps[2]

bdims2$hgt_outlier = x 
ggplot(bdims2, aes(x=hgt_outlier, y=wgt)) + geom_point()

#scaling
#min-max normalization
x = c(3,4,5,6,7)
y = c(9, 10, 12, 13, 15 )
xmin = min(x)
xmax= max(x)
xmin
xmax
(x - xmin) / (xmax- xmin)

ymin = min(y)
ymax = max(y)
(y-ymin) / (ymax-ymin)

min_max = function(x){
  xmin = min(x)
  xmax= max(x)
  xnew =  (x - xmin) / (xmax- xmin) #min/max normalization formula
  return(xnew)
  }
min_max(x)
min_max(y)

#standardization
(x-mean(x)) / sd(x) #same thing can be done with the scale(x) function

