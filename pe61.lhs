> import Data.Digits
> import Data.List

> f3 n = n * (n + 1) `div` 2
> f4 n = truncate(n ** 2)
> f5 n = n * (3 * n - 1) `div` 2
> f6 n = n * (2 * n - 1)
> f7 n = n * (5 * n - 3) `div` 2
> f8 n = n * (3 * n - 2)

> filterOnlyThousands = takeWhile (< 10000) . dropWhile (< 1000)
> f3s = filterOnlyThousands (map f3 [0..])
> f4s = filterOnlyThousands (map f4 [0..])
> f5s = filterOnlyThousands (map f5 [0..])
> f6s = filterOnlyThousands (map f6 [0..])
> f7s = filterOnlyThousands (map f7 [0..])
> f8s = filterOnlyThousands (map f8 [0..])

> f3ds = map (digits 10) f3s
> f4ds = map (digits 10) f4s
> f5ds = map (digits 10) f5s
> f6ds = map (digits 10) f6s
> f7ds = map (digits 10) f7s
> f8ds = map (digits 10) f8s

> f3prefix = map (take 2) f3ds
> f4prefix = map (take 2) f4ds
> f5prefix = map (take 2) f5ds
> f6prefix = map (take 2) f6ds
> f7prefix = map (take 2) f7ds
> f8prefix = map (take 2) f8ds

> f3suffix = map (drop 2) f3ds
> f4suffix = map (drop 2) f4ds
> f5suffix = map (drop 2) f5ds
> f6suffix = map (drop 2) f6ds
> f7suffix = map (drop 2) f7ds
> f8suffix = map (drop 2) f8ds

> isCycle :: [[Integer]] -> [[Integer]] -> Integer -> Bool
> isCycle ps ss x = (elem p ps) && (elem s ss)
>                 where d = digits 10 x
>                       p = take 2 d
>                       s = drop 2 d

> f3s' = filter (isCycle f8suffix f4prefix) f3s
> f4s' = filter (isCycle f3suffix f5prefix) f4s
> f5s' = filter (isCycle f4suffix f6prefix) f5s
> f6s' = filter (isCycle f5suffix f7prefix) f6s
> f7s' = filter (isCycle f6suffix f8prefix) f7s
> f8s' = filter (isCycle f7suffix f3prefix) f8s

*Main> f3s'
[1653,2016,2556,3321,4186,4560,7626,8128,8515]
*Main> f4s'
[1521,1681,2116,3025,5041,5184,5625,6084,6561,7569]
*Main> f5s'
[1617,2147,6112]
*Main> f6s'
[1035,1225,2016,2556,6216,7626]
*Main> f7s'
[1177,2512,3010,3186,8614]
*Main> f8s'
[1045,1281,1825,2133,2640,2821,4033,4485,4720,5985,8640]

*Main> f3s'
[,2016,2556,3321,,4560,,,8515]
*Main> f4s'
[1521,1681,2116,3025,5041,5184,5625,6084,6561,7569]
*Main> f5s'
[,,6112]
*Main> f6s'
[1035,1225,2016,2556,6216,7626]
*Main> f7s'
[1177,2512,3010,3186,8614]
*Main> f8s'
[1045,1281,1825,2133,2640,2821,4033,4485,4720,5985,8640]

6112,1225,2512,1281,