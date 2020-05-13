#!/usr/bin/python
import sys

for line in sys.stdin:
        line = line.strip()
        vals = line.split('|')
        q = vals[8]
        disc = vals[11]
        rev = vals[12]
        if int(disc) < 3:
                print"%s\t%s\t"%(int(q), rev)