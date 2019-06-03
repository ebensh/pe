> import Data.Digits
> import Data.List
> import Data.Maybe

> kMaxNum = 10
> kHalfMaxNum = quot kMaxNum 2
> poss' = permutations [1..kMaxNum-1]

I think these appends are slow...

> poss = [xs ++ [kMaxNum] ++ ys | p <- poss', i <- [0..kHalfMaxNum-1],
>      	     		     	  let (xs, ys) = splitAt i p]

From http://stackoverflow.com/questions/16378773/rotate-a-list-in-haskell

> rotate :: Int -> [a] -> [a]
> rotate _ [] = []
> rotate n xs = zipWith const (drop n (cycle xs)) xs

> isValid :: (Eq a, Num a) => [a] -> Bool
> isValid p = left == right
>   where (outer, inner) = splitAt kHalfMaxNum p
>         left  = map (uncurry (+)) $ zip outer inner
>         right = map (uncurry (+)) $ zip (rotate 1 outer) (rotate 2 inner)

> makeTriples p = [(outer !! i) : take 2 (rotate i inner) | i <- [0..4],
> 	      	   let (outer, inner) = splitAt kHalfMaxNum p]

> rotateTriples t = rotate i t
>                   where i = fromJust $ elemIndex (minimum t) t

> solutionForm :: [Int] -> [[Int]]
> solutionForm = rotateTriples . makeTriples

> score :: Show a => [[a]] -> Integer
> score p = read (concatMap show (concat p)) :: Integer

> solutions' :: [[Int]]
> solutions' = [p | p <- poss, isValid p]

> solutions :: [(Integer, [[Int]])]
> solutions = [(score (solutionForm p), solutionForm p) | p <- solutions']

> solution :: Integer
> solution = fst $ maximum solutions

> main :: IO ()
> main = putStrLn $ show solution