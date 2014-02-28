import math

def s(n):
  m = n % 1
  if m < 0.5:
    return m
  else:
    return 1 - m

def f(x):
  y = 0
  for n in xrange(30):  # Maybe need to increase this
    y += s((2**n)*x) / (2**n)
  if x <= 0.5:
    circle_y = 0.5 - math.sqrt((0.25**2) - abs(0.25-x)**2)
    return min(circle_y, y)
  return y

dx = 0.000001
area = 0
x = 0
while x <= 1.0:
  area += dx * f(x)
  print x, area
  x += dx

print "Answer: ", 0.5-area
