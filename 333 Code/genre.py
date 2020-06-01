#get the count of each genre. remeber, movies can have multiple genres
#is there a primary genre? it seems like they're just listed alphabetically
import csv

f = open('/Users/martinvazquez/Spring2020/DSC_341/project/dataSets/movieDBGrossInclMV.csv')
lines = f.readlines()
f.close()

lst = []
d = {}

#get a gigantic list of every single word thats used in genres (even if its duplicated)
for line in lines[1:]:  #removes the 1st row where all of the 'values' are just the header
    line = line.strip().strip('"')
    line = line.split(',')
    line = line[1:]
    gross = line[9]
    print(gross)
    genres = line[10].strip('"')
    genres = genres.split('|')
    #print(genres)
    lst.extend(genres)


for i in lst:   #remove the duplicates, and do a count
    if i not in d:
        d[i] = 1
    else:
        d[i] +=1

'''with open('genres.csv', mode='w') as csv_file:
    fieldnames = ['genre', 'count']
    writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

    writer.writeheader()
    for key in d:
        writer.writerow({'genre':key, 'count':d[key]})'''
        
