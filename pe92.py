import math

def mutate(x):
  return sum([int(d) ** 2 for d in str(x)])

def main():
  kMax = 10000000
  low = set([1])
  high = set([89])
  for x in xrange(2, kMax):
    xs = [x]
    while True:
      if x in low:
        low.update(xs)
        break
      elif x in high:
        high.update(xs)
        break
      x = mutate(x)
      xs.append(x)
  print len(high)

if __name__=="__main__":
  main()
