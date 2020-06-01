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
Nutrition_v2 <- read_excel("Fall 19/DSC 324/Nutrition_v2.xlsx")
View(Nutrition_v2)

dim(Nutrition_v2)
#8,160 sample size, 30 variables
sum(is.na(Nutrition_v2))

Nutrition_v2_2 <- Nutrition_v2[, c(1, 8:30)]
sum(is.na(Nutrition_v2_2))
#no unfilled values left in the dataset after removing columns 5-7. made all values numerical

M<-cor(Nutrition_v2_2, method="spearman")
M
corrplot(cor(M,method="spearman"), method = "number", type = "lower")


options("scipen"=100, "digits"=5)
round(cor(Nutrition_v2_2), 2)
MCorrTest = corr.test(Nutrition_v2_2, adjust="none")
MCorrTest
M = MCorrTest$p
M
MTest = ifelse(M < .01, T, F)
MTest
colSums(MTest) - 1  

#removed ID because it only correlated with about half of the variables and it is an assigned value
Nutrition_v2_3 <- Nutrition_v2[, c(8:30)]

library(psych)
KMO(Nutrition_v2_3)

library(REdaS)
bart_spher(Nutrition_v2_3)

#raw alpha value of 0.27. std. alpha of 0.83. 
library(psych)
alpha(Nutrition_v2_3,check.keys=TRUE)

p = prcomp(Nutrition_v2_3, center=T, scale=T)
p
plot(p)
abline(1, 0)

summary(p)
print(p)

p2 = psych::principal(Nutrition_v2_3, rotate="varimax", nfactors=3, scores=TRUE)
p2
print(p2$loadings, cutoff=.4, sort=T)

scores <- p2$scores
scores_1 <- scores[,1]

min_score1 <- min(scores_1)
min_score1
max_score1 <- max(scores_1)
max_score1

scores_2 <- scores[,2]
scores_3 <- scores[,3]

min_score2 <- min(scores_2)
min_score2
max_score2 <- max(scores_2)
max_score2

min_score3 <- min(scores_3)
min_score3
max_score3 <- max(scores_3)
max_score3
########################################### for factor analysis
fit = factanal(Nutrition_v2_3, 3)
print(fit$loadings, cutoff=.4, sort=T)
summary(fit)
############start problem 6
census <- read.csv("Fall 19/DSC 324/Census2.csv",header=TRUE, sep=",")
M<-cor(census, method="spearman")
M
corrplot(cor(M,method="spearman"), method = "number", type = "lower")

options("scipen"=100, "digits"=5)
round(cor(census), 2)
MCorrTest = corr.test(census, adjust="none")
MCorrTest
M = MCorrTest$p
M
MTest = ifelse(M < .01, T, F)
MTest
colSums(MTest) - 1  

library(psych)
KMO(census)

p = prcomp(census, center=T, scale=T)
p
plot(p)
abline(1, 0)

summary(p)
print(p)

p2 = psych::principal(census,rotate="varimax", nfactors=2, scores=TRUE)
p2
print(p2$loadings, cutoff=.4, sort=T)

ls(p2)
factors(p2)
p2$factors
p2$scores



#divide everything by 100,000
####
census2<-census[,(1:5)]
census2$MedianHomeVal <-census$MedianHomeVal/100000
p3 = prcomp(census2, center=T, scale=T)
p3
plot(p3)
abline(1, 0)

p5 = psych::principal(census2,rotate="varimax", nfactors=2, covar=TRUE, scores=TRUE)
p5
p4 = psych::principal(census2,rotate="varimax", nfactors=2, scores=TRUE)
p4
print(p4$loadings, cutoff=.4, sort=T)
print(p5$loadings, cutoff = .4, sort=T)
p2
############start problem 7
glass<- read.csv("Fall 19/DSC 324/glass.csv",header=TRUE, sep=",")
glass<-glass[,(1:9)]
glass$R1
head(glass)
cor(glass)

p1 <- ggpairs(glass)
p1
M<-cor(glass, method="spearman")
M
#based on the correlation matrix the variables don't seem to possess too many correlations that are strong. therefore use orthogonal rotation method
#use varimax rotation
options("scipen"=100, "digits"=5)
round(cor(glass), 2)
MCorrTest = corr.test(glass, adjust="none")
MCorrTest

M = MCorrTest$p
M
MTest = ifelse(M < .01, T, F)
MTest

colSums(MTest) - 1
library(psych)
KMO(glass)

library(REdaS)
bart_spher(glass)

library(psych)
alpha(glass,check.keys=TRUE)

p3 = prcomp(glass, center=T, scale=T)
p3
plot(p3)
abline(1,0)

p4 = psych::principal(glass, rotate="varimax", nfactors=3, scores=TRUE)
p4
print(p4$loadings, cutoff=.4, sort=T)


p5 = psych::principal(glass, rotate="varimax", nfactors=4, scores=TRUE)
p5
print(p5$loadings, cutoff=.4, sort=T)

fit2 = factanal(glass, 4)
print(fit2$loadings, cutoff=.4, sort=T)
summary(fit2)

