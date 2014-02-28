from primes import primeSieve

max_n = 100000
primes = frozenset(primeSieve(max_n))

sum = 0

for n in xrange(1, max_n + 1):
  best = 1
  if n not in primes:
    lowest_a = int(n**0.5)
    for a in xrange(n - 1, lowest_a - 1, -1):
      if a**2 % n == a:
        best = a
        break
  sum += best
  print n
print sum
