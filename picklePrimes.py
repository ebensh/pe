import cPickle
from sympy import sieve

def main(maxPrime, outputPath):
  with open(outputPath, 'w') as f:
    cPickle.dump(list(sieve.primerange(2, maxPrime)), f, cPickle.HIGHEST_PROTOCOL)

if __name__=="__main__":
  main(100000000, 'primes_to_100000000.p')
