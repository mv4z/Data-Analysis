who  = read.csv("/Users/martinvazquez/Spring2020/DSC_341/datasets/WHO.csv")
head(who)
tail(who)
class(who)

str(who) #gives the structure of the dataframe
summary(who)

eu = subset(who, Region=="Europe")
head(eu)
tail(eu)
summary(eu)
#notice how mean and other metrics have changed because some extreme values that were in the entire dataset 
#aren't in this

eu$Country
eu$Population #returns vector with just each country's population
#to find the country with the MAX population...
idx_max = which.max(eu$Population)
eu[idx_max,]

#how to save tyour dataframe into a datafile..
write.csv(eu, "../datasets/who_eu.csv", row.names= FALSE)

eu_saved = read.csv("../datasets/who_eu.csv")
head(eu_saved)

#shows all the variables in your current environment (can also be seen there ----->)
ls()

#this is how to remove a variable that is already defined. large dataframes use up RAM
rm(eu_saved)

#perform very basic analysis
summary(eu)
mean(eu$Population)
mean()
median()
mode()
#standard deviation
sd(eu$Population)

#find the country with the smallest prinmary school enrollment female
min(eu$PrimarySchoolEnrollmentFemale, na.rm = TRUE) #NAs have to be removed to actually calculate
eu[which.min(eu$PrimarySchoolEnrollmentFemale), ] #to actually find the country and its stats!

#---------------------------------------------------------------------------------------------
#basic plotting
hist(who$Population)
boxplot(who$LifeExpectancy ~ who$Region)
plot(who$Population, who$LifeExpectancy)

who$Population
mean(who$Population)

mask = who$Population <  150000
whosmall = who[mask, ]
plot(whosmall$Population, whosmall$LifeExpectancy)

table(who$Region)

names(who)

#create a custom column based on life expectancy
who$LifeExpectancyBoolean = who$LifeExpectancy > 60
#converting T/F to binary values
who$LifeExpectancyBoolean = as.integer(who$LifeExpectancyBoolean)
table(who$Region, who$LifeExpectancyBoolean)
prop.table(table(who$Region, who$LifeExpectancyBoolean))

#tapply()
#give first the variable of interest
#the second argument is the subsets you want your data to be broken into
#gets the variable of interest for each subset and performs the specified calculation on it
tapply(who$Population, who$Region, mean)
tapply(who$GNI, who$Region, mean, na.rm = T)
tapply(who$GNI, who$LifeExpectancyBoolean, mean, na.rm=T)
