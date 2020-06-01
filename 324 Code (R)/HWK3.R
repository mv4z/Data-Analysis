library(foreign)
library(CCA)
library(yacca)
library(MASS)

sum(is.na(responses))
na.omit(responses)
responses = na.omit(responses)
sum(is.na(responses))

music <- responses[,1:19]
hobbies_interests <- responses[,32:63]

c = cca(hobbies_interests, music)
c

ls(c)
c$chisq
c$df
summary(c)

canonicalCor = cancor(hobbies_interests, music)
canonicalCor

round(pchisq(c$chisq, c$df, lower.tail=F), 3)



cc_mm = cc(hobbies_interests, music)
loadings_mm = comput(hobbies_interests, music, cc_mm)
ls(loadings_mm)
