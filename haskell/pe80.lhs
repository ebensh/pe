> import Data.Char
> import Data.List
> import Data.Number.CReal

> ns'' = [1..100]
> ns'  = map (showCReal 110 . sqrt) ns''
> ns   = filter (not . isSuffixOf ".0") ns'

> numberToDigits = take 100 . filter isDigit

> digitalSum = sum . map digitToInt

> sums = map (digitalSum . numberToDigits) ns

> main = putStrLn . show $ sum sums