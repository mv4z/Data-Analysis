library(dplyr)
#install.packages('tidyr')
library(tidyr)

df = read.csv('/Users/martinvazquez/Spring2020/DSC_341/project/dataSets/movieDBGrossInclMV.csv')
df <- df %>% select(-c(X.2, X.1))
#no NA for genre or for gross

genres_full <- read.csv('/Users/martinvazquez/Spring2020/DSC_341/project/dataSets/genres.csv')
summary(genres_full)
#split the genres dataset into low and high count, then look at revenue??
genres_low_count <- genres_full %>% filter(count < 500)
genres_high_count <- genres_full %>% filter(count > 500)
#won't make too much sense b/c movies have more than one genre

#frequency plot
ggplot(genres_low_count, aes(genre, count, fill=genre)) + geom_bar(stat='identity', show.legend = F) +
  ggtitle('Genre Frequency') + theme(axis.text.x=element_text(angle =45, vjust = 0.5))
ggplot(genres_high_count, aes(genre, count, fill=genre)) + geom_bar(stat='identity', show.legend = F) +
  ggtitle('Genre Frequency') + theme(axis.text.x=element_text(angle =45, vjust = 0.5))

#create model WITH all 24
#make 24 extra columns in the dataset for the dummy variables
#create model with only high????

