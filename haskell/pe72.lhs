> import Math.Sieve.Phi

> d = 1000000
> s = sieve d
> main = putStrLn $ show $ sum [phi s n | n <- [2..d]]
