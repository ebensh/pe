import math

def mutate(x):
  return sum([int(d) ** 2 for d in str(x)])

def main():
  kMax = 10000000

  low = set([1])
  high = set([89])

  # The maximum number we would need in our set is mutate(9999999),
  # which is 9*9*7 = 567. We optimize by first finding the end point
  # for those 567 numbers and inserting them into our lookup.
  count = 0
  for x in xrange(2, 567+1):
    m = x
    while True:
      if m == 1:
        low.add(x)
        break
      elif m == 89:
        count += 1
        high.add(x)
        break
      m = mutate(m)

  # Does freezing the set make a performance difference?
  low = frozenset(low)
  high = frozenset(high)

  for x in xrange(567+1, kMax):
    m = x
    while True:
      m = mutate(m)
      if m in low:
        break
      elif m in high:
        count += 1
        break

  print count

if __name__=="__main__":
  main()
