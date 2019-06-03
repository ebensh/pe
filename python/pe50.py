from primes import primeSieve
from collections import deque

primes = primeSieve(1000000)
prime_set = frozenset(primes)

best = []
for i, prime in enumerate(primes):
  window = []
  k = i+len(best)+1
  while sum(window) <= 1000000: # 1000000:
    window = primes[i:(i+k)]
    if sum(window) in prime_set:
      best = window
    k = k + 1
  print i, len(best), sum(best), sum(best) in prime_set

  if sum(best) == 997651:
    print "BEST: ", best
    quit()
    
print "Done :) Best: ", best

