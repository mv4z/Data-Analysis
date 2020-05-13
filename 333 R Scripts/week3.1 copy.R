#creating categorical vector
color = c("r", 'b', 'g', 'g', 'b', 'r', 'g')
factor_color = factor(color)
factor_color
summary(factor_color)
table(factor_color) #the table value could also work for just the vector, so 'color' in line 2

shirts = c('S', 'XL', 'XL', 'M', 'M', 'L', 'L')
factor(shirts, ordered=TRUE)
shirts #unless you specify the order, it does it on its own. in this case its alphabetical!
fac_shirts <- factor(shirts, ordered=TRUE, levels=c('S', 'M', 'L','XL'))
summary(fac_shirts)
table(fac_shirts)
fac_shirts
as.character(fac_shirts)
as.numeric(fac_shirts)

#-------------------------------------------------------------------------------------------------------
#matrices
v = 1:24
#creates a 1-column vector, 20 entries long
matrix(v)
#change the number of rows in the vector. entries are filled in by COLUMN
matrix(v, nrow = 4)
#entires in the matrix are filled in now by ROW
matrix(v, nrow=4, byrow=T)
m = matrix(v, ncol=5, byrow=T)#this is the same matrix

#indexing specific values
m[1,3]
m[2,4]

#indexing specific column
m[,3]
#indexing specific row
m[2,]

#indexing multiple rows (or columns)
m[2:3,]
m[c(1,4),] #this is how to get multiple rows that may not follow one another

m[2:3, 3:4]
m[2:4, 1:2]
m[c(2,4), 4:5]
m[c(2,4), c(2,5)]
