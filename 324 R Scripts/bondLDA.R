library(MASS)
data(BondRating)
head(BondRating)

BondRating = BondRating[-c(2)]
BondRating$RATING <- factor(BondRating$RATING)
table(BondRating$RATING)

bondLDA = lda(RATING ~ ., data=BondRating)
bondLDA

plot(bondLDA)

library(readxl)
BondRatingValidation <- read_excel("~/Downloads/BondRating.xls", sheet = 2)
View(BondRatingValidation)
BondRatingValidation <- BondRatingValidation[2:13]
BondRatingValidation = BondRatingValidation[-c(2)]
BondRatingValidation$RATING <- factor(BondRatingValidation$RATING)

bondLDA2 = lda(RATING ~ ., data=BondRatingValidation)
bondLDA2

#using LDA on FIFA dataset

fifa <- Fifa19_Clean[4:26]
fifa <- fifa[-c(2)]
fifa$BodyType <- factor(fifa$BodyType)

fifaLDA = lda(BodyType ~ ., data=fifa)
fifaLDA

fifaDA2 = lda(BodyType ~ ., data=fifa, CV=T)
fifaDA2