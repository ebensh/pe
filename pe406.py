import math
import sys

# Note that we assume a < b.
n = 100
a = 2
b = 3

costs = range(n + 1)
costs[0] = 0
costs[1] = 0
costs[2] = a
costs[3] = min(2 * a, b)

for i in xrange(4, n+1):
  # i = 4
  costs[i] = sys.maxint
  for j in xrange(i / 2 + 1, 0, -1):
    l = b + costs[j]
    r = a + costs[i - 1 - j]
    if max(l, r) < costs[i]:
      print i, j, i-1-j, l, r
    costs[i] = min(costs[i], max(l, r))
  print i, costs[i]

#print costs
print max(costs)
