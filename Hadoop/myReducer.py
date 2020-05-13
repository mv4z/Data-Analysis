#!/usr/bin/python
import sys

curr_id = None
curr_total = 0
id = None

for line in sys.stdin:
        line = line.strip()
        ln = line.split('\t')
        id = int(ln[0])
        if curr_id == id:
                curr_total += int(ln[1])
        else:
              if curr_id != None:
                        print'%d\t%d' % (curr_id, curr_total)
                curr_id = id
                curr_total = int(ln[1])

if curr_id == id:
        print '%s\t%d' % (curr_id, curr_total)