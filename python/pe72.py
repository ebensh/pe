import cPickle
import fractions

# Primes will always add d-1
def main():
  primes = None
  with open('primes_to_1000000.p', 'r') as f:
    primes = set(cPickle.load(f))
  
  count = 0
  for d in xrange(2, 1000000+1):
    print d, count
    if d in primes:
      count += d - 1  # eg. 1/3, 2/3
      continue
    for n in xrange(1, d):
      if fractions.gcd(n, d):
        count += 1
  print "Done :) Total:", count

if __name__=="__main__":
  main()
