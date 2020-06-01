#get the count of each genre. remeber, movies can have multiple genres
#is there a primary genre? it seems like they're just listed alphabetically
#make changes so that you can calculate the average revenue as well
#tuples can be indexed...
#instead of making lst a list of just genres, make it a list of (genre, revenue)
import csv

f = open('/Users/martinvazquez/Spring2020/DSC_341/project/dataSets/movieDBGrossInclMV.csv')
lines = f.readlines()
f.close()

lst = []
d = {}
revd = {}

#get a gigantic list of every single word thats used in genres (even if its duplicated)
for line in lines[1:]:  #removes the 1st row where all of the 'values' are just the header
    line = line.strip().strip('"')
    line = line.split(',')
    line = line[1:]
    gross = line[9]
    genres = line[10].strip('"')
    genres = genres.split('|')
    #print(genres)
    t = (genres, int(gross))
    lst.append(t)


for i in lst:   #remove the duplicates, do a count, total the gross by genre
    for genr in i[0]:
        if genr not in d:
            d[genr] = 1
            revd[genr] = i[1]
        else:
            d[genr] +=1
            revd[genr] += i[1]

avgRev = {}
for key in d:
    avgRev[key] = format((revd[key] / d[key]), '.2f')
print(avgRev)

with open('genreRevenue.csv', mode='w') as csv_file:
    fieldnames = ['genre', 'avgRevenue']
    writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

    writer.writeheader()
    for key in avgRev:
       writer.writerow({'genre':key, 'avgRevenue':avgRev[key]})
        
