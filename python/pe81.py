import sys

puzz = [[131,673,234,103,18],
        [201,96,342,965,150],
        [630,803,746,422,111],
        [537,699,497,121,956],
        [805,732,524,37,331]]

soln = [[sys.maxint]*5 for x in xrange(5)]
soln[4][4] = puzz[4][4]
path = [(4, 4)]

print puzz
print soln
print path
