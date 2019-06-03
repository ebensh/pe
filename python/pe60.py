import cPickle
#import cProfile
import igraph
import itertools
import math

primes = set()

def is_pair(x, y):
  # I knew this was a way to do it, but credit where credit's due :)
  # http://stackoverflow.com/questions/12838549/merge-two-integers-in-python
  if int(math.pow(10,(int(math.log(y,10)) + 1)) * x + y) not in primes: return False
  if int(math.pow(10,(int(math.log(x,10)) + 1)) * y + x) not in primes: return False
  return True

def main(kMaxPrime):
  global primes

  sortedPrimes = []
  with open('primes_to_100000000.p', 'r') as f:
    sortedPrimes = cPickle.load(f)
    primes = set(sortedPrimes)

  g = igraph.Graph()

  for ix, x in enumerate(sortedPrimes):
    g.add_vertex()  # Vertex x has index ix
    edges = []
    for iy, y in enumerate(itertools.takewhile(lambda p: p < x, sortedPrimes)):
      if is_pair(x, y):
        edges.append((ix, iy))
    g.add_edges(edges)
    # Don't check g.omega() here because it's extremely expensive.
    if x > kMaxPrime: break

  print g.largest_cliques()
  for clique in g.largest_cliques():
    primes = map(lambda v: sortedPrimes[v], clique)
    print primes, sum(primes)

if __name__=="__main__":
  main(10000)
  #cProfile.run('main(10000)')
