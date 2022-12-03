import Data.List
import Data.Char

calculateTotalPriority :: (String -> Int) -> FilePath -> IO ()
calculateTotalPriority f path = do
    contents <- readFile path
    let totalPriority = f contents
    print totalPriority

calculateTotalRucksackPriority :: String -> Int
calculateTotalRucksackPriority s = sum (map calculateRucksackPriority (lines s))

calculateRucksackPriority :: String -> Int
calculateRucksackPriority s = let tpl = splitHalf s
    in getPriority (head (intersect (fst tpl) (snd tpl)))

calculateTotalGroupPriority :: String -> Int
calculateTotalGroupPriority s = sum (map calculateGroupPriority (chunks 3 (lines s)))

calculateGroupPriority :: [String] -> Int
calculateGroupPriority s = getPriority (head (intersect (s !! 0) (intersect (s !! 1) (s !! 2))))

splitHalf :: String -> (String, String)
splitHalf s = splitAt (div (length s) 2) s

getPriority :: Char -> Int
getPriority x
    | isUpper x = ord x - 64 + 26
    | otherwise = ord x - 96 

chunks :: Int -> [a] -> [[a]]
chunks n = takeWhile (not . null) . unfoldr (Just . splitAt n)

printAnswer1 :: FilePath -> IO ()
printAnswer1 = calculateTotalPriority calculateTotalRucksackPriority

printAnswer2 :: FilePath -> IO ()
printAnswer2 = calculateTotalPriority calculateTotalGroupPriority