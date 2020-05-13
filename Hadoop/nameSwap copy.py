#!//usr/bin/python
import sys

for line in sys.stdin:
        line = line.strip().split('\t')
        #line = line[0].split('|')
        name = line [1]
        #print(name)
        name = name.split(' ')  #name = [honeydew', 'dim']
        name = '~'.join(name)   #name = 'dim~honeydew'
        line[1] = name
        print'\t'.join(line)





