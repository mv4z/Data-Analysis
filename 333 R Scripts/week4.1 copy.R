library(dplyr)
install.packages('nycflights13')
library(nycflights13)

#select
select(flights, carrier, dep_delay)

#filter
df = select(flights, carrier, dep_delay )
df = filter(df, carrier=='UA')
#avg delay for american airlines
mean(df$dep_delay, na.rm=T)
#avg delay for the entire dataset
mean(flights$dep_delay, na.rm=T)
#filter UA and AA
df_UA_AA = filter(flights, carrier %in% c('UA','AA'))
unique(df_UA_AA$carrier) #check that the column only contains the 2 airlines

# %>% the item on the left replaces the first variable of the function on the right
#pipe notation
flights %>% select(carrier, dep_delay)
flights %>% select(carrier, dep_delay) %>% filter(carrier == 'UA')

#slice
#insert dataset, and the row indexes that you want
#equivalent to flights[c(1,3,6), ]
slice(flights, c(1,3,6))

#find the carrier with the largest dep_delay
max(flights$dep_delay, na.rm=T)
rowIdx = which.max(flights$dep_delay)
flights[rowIdx,  ]
#same way to do ^^^ but using dplyr
flights %>% slice(which.max(dep_delay))

#mutate
#applying different functions on specified columns, and creating a new one and adding it to the dataframe
flights %>% select(carrier, dep_delay, arr_delay) %>% mutate(total_delay = dep_delay + arr_delay)
df = flights %>% select(carrier, dep_delay, arr_delay, distance, air_time) %>% 
  mutate(total_delay = dep_delay + arr_delay, avg_speed = distance / air_time*60)

#arrange
#sort the data based on column of your choice
df %>% arrange(avg_speed)
df %>% arrange(desc(avg_speed))
df %>% arrange(desc(total_delay), desc(avg_speed))

#summarize()
#aggregate the data and give a single output
mean(df$total_delay, na.rm=T)
summarize(df, mean_dd = mean(total_delay, na.rm=T)) #although this is a single line, it is still a dataframe

#groupby
#grouping df into subsets, and then you can do operations on them
df %>% group_by(carrier) %>% summarize(mean(total_delay, na.rm=T)) #shows avg total delay for each carrier!
df %>% group_by(carrier) %>% summarize(mean_dl = mean(total_delay, na.rm=T), N = n()) #added a number of flights column 

#month == may, find carrier w the largest avg arrival delay
flights %>% filter(month == 5) %>% group_by(carrier) %>% summarize(mean_arr_delay = mean(arr_delay, na.rm = T)) %>%
  arrange(mean_arr_delay)

#create a summary where you can see avg total delay for each arrier over a 12 month period
#report the airline with the smallest avg total delay. WHich month is it in?
#report the airline with the largest total delay
flights %>% mutate(total_delay = arr_delay + dep_delay) %>% group_by(carrier, month)%>% 
  summarize(m_a_d = mean(total_delay, na.rm = T)) %>%
  arrange(m_a_d)



