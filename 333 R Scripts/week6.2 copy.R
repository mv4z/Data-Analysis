wine = read.csv('/Users/martinvazquez/Spring2020/DSC_341/datasets/wine.csv')
install.packages('ggcorrplot')
library(tidyverse)
str(wine)
summary(wine)
anyNA(wine)

ggplot(wine, aes(x=Year, y=Price)) + geom_point()
ggplot(wine, aes(x=FrancePop, y=Price)) + geom_point()
ggplot(wine, aes(x=HarvestRain, y=Price)) + geom_point()
ggplot(wine, aes(x=WinterRain, y=Price)) + geom_point()
ggplot(wine, aes(x=AGST, y=Price)) + geom_point() #you can kind of identify a relationship here

library(ggcorrplot)
rm(corr_matr)
cormat = cor(wine) #correlation matrix
ggcorrplot(cormat) #visualization of the correlation matrix
ggcorrplot(cormat, type='lower') #since the data is mirrored you only need to look at half of it


model1 <- lm(formula = Price ~ WinterRain, data = wine) #price is dependent, WinterRain is independent
  #modeling Price as a function of WinterRain
summary(model1)
model2 <- lm(formula = Price ~ HarvestRain, data = wine) 
summary(model2)
model3 <- lm(formula = Price ~ AGST, data = wine) 
summary(model3)
  #this is the best model so far based on looking at the significance of the variables
  #by looking at the Multiple R2 of the model
coefs = coef(model3)
model3$coefficients
  #the two functions above give the coefficients of the model. they give the same exact results

#making predictions based on the linear regression model
b = coefs[1]
m = coefs[2]
head(wine)
yhat <- c(b + 17.1167*m,
b + 16.7333 * m,
b + 17.1500 * m)

y = wine$Price[1:3]
y - yhat 
  #calcualted the residuals by subtracting the predicted values from the actual values
model3$residuals
  #this did the same thing with the appropriate model
wine$Price - model3$fitted.values
  #this is another way to find residuals


#calculate sum of the square of the errors [BASE MODEL]
mean_price = wine$Price %>% mean()
residuals = wine$Price - mean_price
SSE <- sum(residuals ^ 2)
SSE

SSE2 <- sum(model3$residuals ^ 2)
SSE2
  #SSE calculated based on residuals from model3


#multiple linear regression
model4 <- lm(formula = Price ~ AGST + HarvestRain + WinterRain, data=wine)
summary(model4)

model5 <- lm(formula = Price ~ ., data=wine)
summary(model5)
  #to create a model with every single variable other than Price
  #Age and Year are basically the same thing in the data, so you shouldnt be using both!
  #in the model summary, NAs will populate for estimate, stderror, and other metrics
  #in this case, then Age is excluded from the model
model6 <- lm(formula = Price ~ .-Age, data=wine)
summary(model6)
  #model6 produces the same reuslts as model 5!