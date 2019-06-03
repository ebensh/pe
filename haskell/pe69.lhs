> import Data.List
> import Math.Sieve.Phi

> n = 1000000
> s = sieve n
> main = putStrLn $ show $ maximum [(fromIntegral x / fromIntegral (phi s x), x) | x <- [2..n]]