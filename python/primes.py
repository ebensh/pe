def primeSieve(n):
  A=[0,0]+[1 for i in range(n-1)]
  primes=[]; i=2; sqrtN=int(n**.5)
  for i in xrange(2,sqrtN+1):
    if A[i]==1:
      for j in xrange(i*i,n+1,i): A[j]=0
  return [i for i, prime in enumerate(A) if prime]
