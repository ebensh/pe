import sys

best = sys.maxint
best_size = ()

for rows in xrange(1, 101):
    for cols in xrange(1, rows + 1):
        s = 0
        for a in xrange(rows):
            for b in xrange(cols):
                s += (rows-a)*(cols-b)
        d = abs(2000000 - s)
        if d <= best:
            best_size = (rows, cols, d)
            best = d
            print "New best: ", best_size
        #print rows, cols, s

print "Final best: ", best_size
