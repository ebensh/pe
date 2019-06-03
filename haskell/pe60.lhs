> import Data.Array
> import Data.Digits
> import Data.Graph
> import Data.Numbers.Primes

> pairs :: Integral a => [a] -> [([a], [a])]
> pairs l = [(digits 10 x, digits 10 y) | x <- l, y <- l, x < y]

> primes_of_interest :: [Integer]
> primes_of_interest= takeWhile (< 1000) primes

> prime_digits_pairs :: [([Integer], [Integer])]
> prime_digits_pairs = pairs primes_of_interest

> is_prime_pair :: (Integral a) => (a, a) -> Bool
> is_prime_pair (x, y) = isPrime x && isPrime y

> concat_pair :: Integral a => ([a], [a]) -> (a, a)
> concat_pair (x, y) = (unDigits 10 (x ++ y), unDigits 10 (y ++ x))

> prime_edges :: [([Integer], [Integer])]
> prime_edges = filter (is_prime_pair . concat_pair) prime_digits_pairs

> min_vertex = minimum $ map (uncurry min) prime_edges
> max_vertex = maximum $ map (uncurry max) prime_edges

 pG = buildG (min_vertex, max_vertex) prime_edges
 at_least_5_connections = map fst $ filter (\(p, d) -> d >= 5) (assocs (outdegree pG))

At this point we want "edges"