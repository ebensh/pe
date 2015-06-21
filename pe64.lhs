> import Data.List

Types

> data PeriodStep = PeriodStep { m :: Integer
>      		    	       , d :: Integer
> 			       , a :: Integer
>			       } deriving (Show)

Computation

https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Continued_fraction_expansion

> flrt :: Integer -> Integer
> flrt = floor . sqrt . fromIntegral

> iterateUntil :: (a -> Bool) -> (a -> a) -> a -> [a]
> iterateUntil p f x
>   | p x       = [x]
>   | otherwise = x : iterateUntil p f (f x)

> step :: Integer -> PeriodStep -> PeriodStep
> step s (PeriodStep {m = m, d = d, a = a}) = PeriodStep m' d' a'
>   where m' = d * a - m
>         d' = (s - m' * m') `quot` d
>         a' = ((flrt s) + m') `quot` d'

> expansion :: Integer -> [PeriodStep]
> expansion s = iterateUntil ((==) (2 * flrt s) . a) (step s) (PeriodStep 0 1 (flrt s))

> periodLength :: Integer -> Int
> periodLength = (flip (-)) 1 . length . expansion

Input

> kMaxN = 10000
> ns = [n | n <- [1..kMaxN], flrt n * flrt n /= n]

Output

> answer = length $ filter odd $ map periodLength ns
> main = putStrLn (show answer)