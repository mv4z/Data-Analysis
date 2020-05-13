
library(foreign)
library(CCA)
library(yacca)
library(MASS)

#Read in Iris Data
setwd("insert working directory")

mmreg = read.csv("mmreg.csv", header = TRUE, sep = ",")
head(mmreg)

#See the first six lines of the data
head(mmreg)


###################################################################
# Exploring correlations between psychology and academics


###################################################################
# This is a nice function for computing the Wilks lambdas for 
# CCA data from the CCA library's method
# It computes the wilkes lambas the degrees of freedom and te 
# p-values
###################################################################

ccaWilks = function(set1, set2, cca)
{
  ev = ((1 - cca$cor^2))
  ev
  
  n = dim(set1)[1]
  p = length(set1)
  q = length(set2)
  k = min(p, q)
  m = n - 3/2 - (p + q)/2
  m
  
  w = rev(cumprod(rev(ev)))
  
  # initialize
  d1 = d2 = f = vector("numeric", k)
  
  for (i in 1:k) 
  {
    s = sqrt((p^2 * q^2 - 4)/(p^2 + q^2 - 5))
    si = 1/s
    d1[i] = p * q
    d2[i] = m * s - p * q/2 + 1
    r = (1 - w[i]^si)/w[i]^si
    f[i] = r * d2[i]/d1[i]
    p = p - 1
    q = q - 1
  }
  
  pv = pf(f, d1, d2, lower.tail = FALSE)
  dmat = cbind(WilksL = w, F = f, df1 = d1, df2 = d2, p = pv)
}

###################################################################
# Now, lets do some computation
###################################################################

psych = mmreg[, 1:3]
academic = mmreg[,4:8]

# This gives us the cannonical correlates, but no significance tests
c = cancor(psych, academic)
c

# The CCA library has more extensive functionality
library(CCA)

#Breakdown of the Correlations
matcor(psych, academic)

#Correlations between sepal and sepal (X)
#Correlations between petal and petal (Y)
cc_mm = cc(psych, academic)
cc_mm$cor

#Funcrions for CCA
ls(cc_mm)

#XCoef Correlations
cc_mm$xcoef

#YCoef Correlations
cc_mm$ycoef

#Calculate Scores
loadings_mm = comput(psych, academic, cc_mm)
ls(loadings_mm)

#Correlation X Scores
loadings_mm$corr.X.xscores

#Correlation Y Scores
loadings_mm$corr.Y.yscores

#Wilk's Lambda Test
wilks_mm = ccaWilks(psych, academic, cc_mm)
round(wilks_mm, 2)

# Now, let's calcualte the standardized coefficients
s1 = diag(sqrt(diag(cov(psych))))
s1 %*% cc_mm$xcoef

s2 = diag(sqrt(diag(cov(academic))))
s2 %*% cc_mm$ycoef

# A basic visualization of the cannonical correlation
plt.cc(cc_mm)

################################################################
# Now, let's try it with yacca
################################################################

library(yacca)
c2 = cca(psych,academic)
c2

#CV1
helio.plot(c2, cv=1, x.name="Psych Values", 
           y.name="Academic Values")

#CV2
helio.plot(c2, cv=2, x.name="Psych Values", 
           y.name="Academic Values")

#Function Names
ls(c2)

# Perform a chisquare test on C2
c2
ls(c2)
c2$chisq
c2$df
summary(c2)
round(pchisq(c2$chisq, c2$df, lower.tail=F), 3)
