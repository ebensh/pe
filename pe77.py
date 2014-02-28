from collections import deque
from primes import primeSieve

N = 71
primes = filter(lambda x: x <= N, primeSieve(1000))
primes.reverse()
print N, primes

def countBreakdowns(goal, cur, ps):
  while ps and ps[0] > goal:
    ps.popleft()
  if not ps:
    return 0
  count = 0
  if goal - ps[0] == 0:
    print "Soln found: ", cur + [ps[0]]
    count += 1
  for poss in ps:
    pass_on_goal = goal - poss
    pass_on_cur = list(cur) + [poss]
    pass_on_ps = deque(ps)
    while pass_on_ps and pass_on_ps[0] > poss:
      pass_on_ps.popleft()
    if pass_on_ps:
      count += countBreakdowns(pass_on_goal, pass_on_cur, pass_on_ps)
  return count

poss = deque(primes)
print countBreakdowns(N, [], poss)
