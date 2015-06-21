> import Data.List
> import Data.Digits

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

http://www.akalin.cx/number-theory-haskell-foray

> get_convergents (a_0 : a_1 : as) = pqs
>     where
>       pqs = (p_0, q_0) : (p_1, q_1) :
>             zipWith3 get_next_convergent pqs (tail pqs) as
> 
>       p_0 = a_0
>       q_0 = 1
> 
>       p_1 = a_1 * a_0 + 1
>       q_1 = a_1
> 
>       get_next_convergent (p_i, q_i) (p_j, q_j) a_k = (p_k, q_k)
>           where
>             p_k = a_k * p_j + p_i
>             q_k = a_k * q_j + q_i

> es = 2 : concatMap (\x -> [1, x, 1]) [2, 4..]

 convergents s n = take n $ get_convergents $ map a (iterate (step s) (PeriodStep 0 1 (flrt s)))

> answer = sum $ digits 10 p
>   where p = fst $ (get_convergents es) !! 99