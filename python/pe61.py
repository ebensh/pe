from collections import deque
import igraph
import itertools
import math

def scanl(xs):
  total = 0
  for x in xs:
    total += x
    yield total

def scanl1(xs):
  yield 0
  for x in scanl(xs):
    yield x  # Is there a better way w/ itertools?

def triangle(n): return n * (n + 1) / 2
def square(n): return n ** 2
def pentagonal(n): return n * (3 * n - 1) / 2
def hexagonal(n): return n * (2 * n - 1)
def heptagonal(n): return n * (5 * n - 3) / 2
def octagonal(n): return n * (3 * n - 2)

def between(low, high, xs):  # [low, high]
  return itertools.takewhile(lambda y: y <= high, itertools.dropwhile(lambda x: x < low, xs))

def genNs(low, high, func):
  return between(low, high, itertools.imap(func, itertools.count(start=1, step=1)))

assert list(genNs(1, 15, triangle)) == [1, 3, 6, 10, 15]
assert list(genNs(1, 25, square)) == [1, 4, 9, 16, 25]
assert list(genNs(1, 35, pentagonal)) == [1, 5, 12, 22, 35]
assert list(genNs(1, 45, hexagonal)) == [1, 6, 15, 28, 45]
assert list(genNs(1, 55, heptagonal)) == [1, 7, 18, 34, 55]
assert list(genNs(1, 65, octagonal)) == [1, 8, 21, 40, 65]

def n3s(): return list(genNs(1000, 9999, triangle))
def n4s(): return list(genNs(1000, 9999, square))
def n5s(): return list(genNs(1000, 9999, pentagonal))
def n6s(): return list(genNs(1000, 9999, hexagonal))
def n7s(): return list(genNs(1000, 9999, heptagonal))
def n8s(): return list(genNs(1000, 9999, octagonal))
def ns(): return [n3s(), n4s(), n5s(), n6s(), n7s(), n8s()]

def permutations_without_rotations(l):
  # http://stackoverflow.com/a/9038322
  # Remove the first element, permute the rest, then add it back.
  for tail in itertools.permutations(itertools.islice(l, 1, None)):
    yield [l[0]] + list(tail)

def top2(x): return int(x / 100)
def bottom2(x): return x - int(x / 100) * 100

def main():
  kPermutationLength = 6
  for permutation in permutations_without_rotations(xrange(kPermutationLength)):
  #for permutation in [[0, 4, 1, 2, 5, 3]]:
    numberLists = map(ns().__getitem__, permutation)
    numberListOffsets = list(scanl1(map(len, numberLists)))[:-1]
    def vertex(listIndex, numberIndex):
      return numberListOffsets[listIndex] + numberIndex
    def number(vertexIndex):
      for i, offset in enumerate(numberListOffsets):
        if len(numberLists[i]) + offset > vertexIndex:
          return numberLists[i][vertexIndex - offset]

    numVerticies = sum(map(len, numberLists))
    g = igraph.Graph(numVerticies, directed=True)

    #print permutation
    for i in xrange(kPermutationLength):
      i1 = i
      i2 = (i + 1) % kPermutationLength
      for ix, x in enumerate(numberLists[i1]):
        for iy, y in enumerate(numberLists[i2]):
          if bottom2(x) == top2(y):
            #print "  ", x, y, vertex(i1, ix), vertex(i2, iy)
            g.add_edge(vertex(i1, ix), vertex(i2, iy))

    # igraph thinks the shortest path from a node to itself is length 1. I
    # cannot find a way to destroy this stupid assumption, so this is my hack.
    lastListIx = kPermutationLength - 1
    lastList = numberLists[-1]
    for ix, _ in enumerate(numberLists[0]):
      for iy, _ in enumerate(numberLists[-1]):
        v1 = vertex(0, ix)
        v2 = vertex(kPermutationLength - 1, iy)
        path0toLast = g.get_shortest_paths(v1, v2)[0]
        pathLastto0 = g.get_shortest_paths(v2, v1)[0]
        if path0toLast and pathLastto0:
          path = map(number, path0toLast)
          print path, sum(path)

if __name__=='__main__':
  main()
