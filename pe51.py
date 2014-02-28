import itertools
import operator
from collections import Counter
from primes import primeSieve

primes = primeSieve(10000000)
start = 56003
primes = [prime for prime in itertools.dropwhile(lambda x: x < start, primes)]
prime_set = frozenset(primes)

# We need to change at least three digits, because if we increment
# one or two digits there will always be three in the set that are
# divisible by 3 (if the sum of digits is div by 3, then the number is).

# One optimization we can make is to only replace numbers with 3 of the same
# digit, eg. ABAAB, we can replace the A's
# And we only need to do this for A \in {0, 1, 2}

interesting_primes = []
for prime in primes:
  prime_str = str(prime)
  digit_counts = Counter(str(prime)[0:len(str(prime)) - 1])
  interesting_digit = '-1'
  if digit_counts['0'] == 3: interesting_digit = '0'
  elif digit_counts['1'] == 3: interesting_digit = '1'
  elif digit_counts['2'] == 3: interesting_digit = '2'
  if interesting_digit != '-1':
    count = 0
    for i in xrange(10):
      if int(str.replace(prime_str, interesting_digit, str(i))) in prime_set:
        count += 1
    if count >= 8:
      print "Base prime: ", prime
      for i in xrange(10):
        if int(str.replace(prime_str, interesting_digit, str(i))) in prime_set:
          print "FOUND: ", int(str.replace(prime_str, interesting_digit, str(i)))
