library(tidyverse)
install.packages('RColorBrewer')
library(RcolorBrewer)
clean = read.csv('/Users/martinvazquez/Spring2020/DSC_341/project/dataSets/movieDBGrossInclMV.csv')
clean <- clean %>% filter(is.na(gross) == F)
write.csv(clean, '/Users/martinvazquez/Spring2020/DSC_341/project/dataSets/movieDBGrossInclMV.csv')
summary(clean$genres)

genres = read.csv('/Users/martinvazquez/Spring2020/DSC_341/project/genres.csv')
genres

#create genre frequency bar chart
ggplot(genres, aes(genre, count, fill=genre)) + geom_bar(stat='identity', show.legend = F) +
  ggtitle('Genre Frequency') + theme(axis.text.x=element_text(angle =45, vjust = 0.5))

summary(clean$gross)
#max gross: 760505847 

#the mean revenue for each genre
genreRevenue = read.csv('/Users/martinvazquez/Spring2020/DSC_341/project/dataSets/genreRevenue.csv')
head(genreRevenue)
scaledGenreRevenue <- genreRevenue %>% mutate(genre, avgRevenue = avgRevenue/1000000)

#plot the mean revenue for each genre
ggplot(scaledGenreRevenue, aes(genre, avgRevenue)) + geom_bar(stat='identity', show.legend = F, fill='#00e7fc') +
  ggtitle('Average Gross per Genre') + theme(axis.text.x=element_text(angle =45, vjust = 0.5)) + ylab("Average Gross (1 Billion)")


