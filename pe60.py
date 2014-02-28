from primes import primeSieve
import itertools

MAX_PRIME = 1000 #1000000
primes = primeSieve(MAX_PRIME)
greatest_prime = primes[-1]
primes_to_check = filter(lambda p: p <= greatest_prime / 2, primes)
prime_set = frozenset(primes)

def is_prime_pair(s_x, s_y):
  return int(s_x + s_y) in prime_set and int(s_y + s_x) in prime_set

prime_pairs = [set()]*len(primes_to_check)

for i, p1 in enumerate(primes_to_check):
  s1 = str(p1)
  for p2 in primes_to_check[i+1:]:
    print p1, p2
    if is_prime_pair(s1, str(p2)):
      prime_pairs[p1].add(p2)

print prime_pairs[7]
