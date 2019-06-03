from math import fabs, sqrt

def approx_equals(x, y):
    return fabs(x - y) < 0.1

# https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Continued_fraction_expansion
def period_length(s, sqrts):
    m = 0
    d = 1
    a = int(sqrts)
    sentinel = 2 * a
    count = 0
    while True:
        m = d * a - m
        d = (s - m * m) / d
        a = (int(sqrts) + m) / d
        count += 1
        if a == sentinel: return count

cnt = 0
for i in xrange(2, 10001):  # 10001
    x = sqrt(i)
    if x == int(x): continue  # Skip perfect squares
    pl = period_length(i, x)
    print i, pl
    if pl % 2:
        cnt += 1

print cnt
