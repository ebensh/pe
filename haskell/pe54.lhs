> import Data.Char
> import Data.Maybe
> import Data.List
> import System.IO

> data Suit = Club | Diamond | Heart | Spade deriving (Eq, Ord, Show)
> data Card = Card { value :: Int
>                  , suit :: Suit } deriving (Show)

> data Rank = HighCard | OnePair | TwoPair | ThreeOfAKind | Straight
>           | Flush | FullHouse | FourOfAKind | StraightFlush | RoyalFlush
>           deriving (Eq, Ord, Show)
> data Score = Score { rank :: Rank
>                    , values :: [Int] }
>           deriving (Eq, Ord, Show)

=== Parsing methods:

> chr2suit chr
>   | chr == 'C' = Club
>   | chr == 'D' = Diamond
>   | chr == 'H' = Heart
>   | chr == 'S' = Spade

> chr2value chr
>   | chr == 'T' = 10
>   | chr == 'J' = 11
>   | chr == 'Q' = 12
>   | chr == 'K' = 13
>   | chr == 'A' = 14
>   | otherwise = (ord chr) - (ord '0')

> str2card (value_chr:suit_chr:[]) = Card v s
>   where v = chr2value value_chr
>         s = chr2suit suit_chr

Some helpful testing variables:
str2card t_string_card
map str2card $ words t_string_game

> t_string_card = "8C"
> t_string_game = "8C TS KC 9H 4S 7D 2S 5D 3S AC"
> t_hand = map (uncurry Card) [(10, Club), (11, Club), (12, Club), (13, Club), (14, Club)]

=== Hand computation methods:

Because we by default compare only by value on cards a lot of methods become nicer.

> highCard :: [Card] -> Maybe Score
> highCard cs = Just $ Score HighCard (reverse . sort $ map value cs)

getSets takes a length desired (2 for pairs, 3 for set, etc.)
and a hand and separates it into two lists: those that meet the criteria for
that length and those that don't. We can then create things like onePair, twoPair,
threeOfAKind, etc. by checking whether the list of values that meet that criteria
is non-empty.

> getSets :: Int -> [Card] -> ([Int], [Int])
> getSets n cs = (sets', rest')
>   where (sets, rest) = partition ((>= n) . length) (group . reverse . sort $ (map value cs))
>         sets' = concat sets
>         rest' = concat rest

> onePair :: [Card] -> Maybe Score
> onePair cs
>   | length pairs < 2 = Nothing
>   | otherwise        = Just $ Score OnePair (pairs ++ rest)
>   where (pairs, rest) = getSets 2 cs

> twoPair :: [Card] -> Maybe Score
> twoPair cs
>   | length pairs < 4 = Nothing
>   | otherwise        = Just $ Score TwoPair (pairs ++ rest)
>   where (pairs, rest) = getSets 2 cs

> threeOfAKind :: [Card] -> Maybe Score
> threeOfAKind cs
>   | triples == [] = Nothing
>   | otherwise     = Just $ Score ThreeOfAKind (triples ++ rest)
>   where (triples, rest) = getSets 3 cs

> fourOfAKind :: [Card] -> Maybe Score
> fourOfAKind cs
>   | quadruples == [] = Nothing
>   | otherwise        = Just $ Score FourOfAKind (quadruples ++ rest)
>   where (quadruples, rest) = getSets 4 cs

> straight :: [Card] -> Maybe Score
> straight cs
>   | (length vs == 5) && (head vs - last vs == 4)= Just $ Score Straight vs
>   | otherwise      = Nothing
>   where vs = nub . reverse . sort $ map value cs

> flush :: [Card] -> Maybe Score
> flush cs
>   | length ss == 1 = Just $ Score Flush vs
>   | otherwise      = Nothing
>   where vs = reverse . sort $ map value cs
>         ss = nub $ map suit cs

> fullHouse :: [Card] -> Maybe Score
> fullHouse cs
>   | map fst ss' == [3, 2] = Just $ Score FullHouse (concatMap snd ss')
>   | otherwise             = Nothing
>   where ss   = group . reverse . sort $ map value cs
>         ss'  = reverse . sort $ zip (map length ss) ss

> straightFlush :: [Card] -> Maybe Score
> straightFlush cs
>   | isJust strt && isJust flsh = Just $ Score StraightFlush (values (fromJust strt))
>   | otherwise                  = Nothing
>   where strt = straight cs
>         flsh = flush cs

> royalFlush :: [Card] -> Maybe Score
> royalFlush cs
>   | isJust strtFlsh && (maximum (values (fromJust strtFlsh)) == 14) = Just $ Score RoyalFlush (values (fromJust strtFlsh))
>   | otherwise                                                       = Nothing
>   where strtFlsh = straightFlush cs

> handScore' :: [Card] -> [Maybe Score]
> handScore' cs =  map (uncurry ($)) (zip hands (repeat cs))
>   where hands = [royalFlush, straightFlush, fourOfAKind, fullHouse, flush,
>                  straight, threeOfAKind, twoPair, onePair, highCard]

> handScore :: [Card] -> Score
> handScore cs = fromJust . head $ dropWhile isNothing (handScore' cs)

> splitGameIntoHands :: [Card] -> ([Card], [Card])
> splitGameIntoHands = splitAt 5

> game2Scores :: String -> (String, Score, Score, Int)
> game2Scores g
>   | handScore x > handScore y = (g, handScore x, handScore y, 1)
>   | handScore x < handScore y = (g, handScore x, handScore y, 2)
>   | otherwise = error "Hands in file should not be ties!"
>   where (x, y) = splitGameIntoHands (map str2card $ words g)

> game2Winner :: String -> Int
> game2Winner g
>   | handScore x > handScore y = 1
>   | handScore x < handScore y = 2
>   | otherwise = 3  -- what???
>   where (x, y) = splitGameIntoHands (map str2card $ words g)

> t1="5H 5C 6S 7S KD 2C 3S 8S 8D TD"
> t1x = [Card {value = 5, suit = Heart},Card {value = 5, suit = Club},Card {value = 6, suit = Spade},Card {value = 7, suit = Spade},Card {value = 13, suit = Diamond}]
> t1y = [Card {value = 2, suit = Club},Card {value = 3, suit = Spade},Card {value = 8, suit = Spade},Card {value = 8, suit = Diamond},Card {value = 10, suit = Diamond}]
> t2="5D 8C 9S JS AC 2C 5C 7D 8S QH"
> t3="2D 9C AS AH AC 3D 6D 7D TD QD"
> t4="4D 6S 9H QH QC 3D 6D 7H QD QS"
> t5="2H 2D 4C 4D 4S 3C 3D 3S 9S 9D"

> main = do
>   hands <- getContents
>   mapM_ putStrLn (map (show . game2Winner) (lines hands))
