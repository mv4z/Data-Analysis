library(Hmisc) #Describe Function
library(psych) #Multiple Functions for Statistics and Multivariate Analysis
library(GGally) #ggpairs Function
library(ggplot2) #ggplot2 Functions
library(vioplot) #Violin Plot Function
library(corrplot) #Plot Correlations
library(REdaS) #Bartlett's Test of Sphericity
library(psych) #PCA/FA functions
library(factoextra) #PCA Visualizations
library("FactoMineR") #PCA functions
library(ade4) #PCA Visualizations

library(readxl)
Fifa19_Clean <- read_excel("Fifa19_Clean.xlsx")
View(Fifa19_Clean)

#factor analysis only applies to numerical variables...therefore....clean the above data up
#should the preferred foot and body type variables be changed to categorical or should they just be removed for the dataset
#for the sake of the factor analysis?
#decide to submit FA without categorical variables, then perform mixed factor analysis

#remove the categorical varirables from the data
Fifa19_Clean_NO_Categorical = Fifa19_Clean[,(6:26)]

#check correlations
cor(Fifa19_Clean_NO_Categorical)
M<-cor(Fifa19_Clean_NO_Categorical, method="spearman")
M
corrplot(cor(M,method="spearman"), method = "number", type = "lower")

KMO(Fifa19_Clean_NO_Categorical)

library(REdaS)
bart_spher(Fifa19_Clean_NO_Categorical)
library(psych)

#create a scree plot in order to see how many factors should be in the FA
p = prcomp(Fifa19_Clean_NO_Categorical, center=T, scale=T)
p
plot(p)
abline(1,0)
#the decline is very steep. but ther are 4 factors above the line. FA will be done with 3 and 4 factors

#the FA for 3 factors, using a cutoff of .4
fit_1 = factanal(Fifa19_Clean_NO_Categorical, 3)
print(fit_1$loadings, cutoff=.4, sort=T)
summary(fit_1)
#notice that there is cross-loading as well as overall and reactions which don't fit anywhere
#3 factor solution with overall & reactions removed
Fifa19_for_3FA<- subset(Fifa19_Clean_NO_Categorical, select = -c(Overall, Reactions) )
fit2 = factanal(Fifa19_for_3FA, 3)
print(fit2$loadings, cutoff=.5, sort=T)
summary(fit2)
#ran it again, and now jumping doesnt fit anywhere. remove and run again.
Fifa19_for_3FA<- subset(Fifa19_for_3FA, select = -c(Jumping) )
fit3 = factanal(Fifa19_for_3FA, 3)
print(fit3$loadings, cutoff=.5, sort=T)
summary(fit3)
#try removing strength to see what happens...
Fifa19_for_3FA_noStrength <- subset(Fifa19_for_3FA, select = -c(Strength))
fit6 =  factanal(Fifa19_for_3FA_noStrength, 3)
print(fit6$loadings, cutoff = .5, sort = T)
summary(fit6)
#cross loading everywhere, entire model is different. DONT DO*****


#the FA for 2 factors, using a cutoff of .4
fit4 = factanal(Fifa19_Clean_NO_Categorical, 2)
print(fit4$loadings, cutoff=.4, sort=T)
summary(fit4)
#there are 4 variables (Overall, Reactions, Jumping, and Strength which don't fit into any 2 of the factors in the 2 factor model. here is a dataset
#that does not include them)
Fifa19_for_2FA<- subset(Fifa19_Clean_NO_Categorical, select = -c(Overall, Reactions, Jumping, Strength))

#will run again with 2 factors with new dataset. increase cutoff to .5 like in 4 factors to reduce cross-loading
fit7 =  factanal(Fifa19_for_2FA, 2)
print(fit7$loadings, cutoff = .5, sort = T)
summary(fit7)





