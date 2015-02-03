import cPickle
import itertools
import math
import numpy as np

def main():
  sortedPrimes = None
  kThreshold = 50000000


  # The max prime we need to go up to is 7071 (sqrt(50000000)).
  # Actually a bit less, but that's okay :)
  with open('primes_to_1000000.p', 'r') as f:
    sortedPrimes = np.array(list(itertools.takewhile(
        lambda x: x <= math.sqrt(kThreshold), cPickle.load(f))))

  n2s = sortedPrimes * sortedPrimes
  n3s = n2s * sortedPrimes
  n4s = n2s * n2s

  n2s = n2s[n2s < kThreshold]
  n3s = n3s[n3s < kThreshold]
  n4s = n4s[n4s < kThreshold]
  print len(n2s), len(n3s), len(n4s)
  poss = [x + y + z for x in n2s for y in n3s for z in n4s if x + y + z < kThreshold]
  print "Solution:", len(set(poss))

if __name__=="__main__":
  main()
