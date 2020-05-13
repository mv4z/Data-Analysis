#!/usr/bin/python
import sys

for line in sys.stdin:
        line = line.strip().split('\t')
        addr = line[1]
        city = line[2]
        if (len(addr) > 5):
                line[1] = addr[:5]
        n = city[-1]
        line[2] = city.replace(n, (" " + '#' + n ))
        print'\t'.join(line)











