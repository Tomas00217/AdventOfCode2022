import Data.List

getElfCalories :: [String] -> [Integer]
getElfCalories allCalories = (map (\x -> sum (map read x)) (splitList (\x -> x /= "") allCalories))

splitList :: (a -> Bool) -> [a] -> [[a]]
splitList p [] = []
splitList p xs = let (y, ys) = span p xs
                     (z, zs) = span (not . p) ys
            in if null y then splitList p zs else y : splitList p zs

getMaxCalories :: FilePath -> IO Integer
getMaxCalories path = do
    contents <- readFile path
    let calories = lines contents
    let maxCalories = maximum (getElfCalories calories)
    return maxCalories

getTopNMaxCalories :: Int -> FilePath -> IO Integer
getTopNMaxCalories n path = do
    contents <- readFile path
    let calories = lines contents
    let maxCalories = sum (take n (reverse (sort (getElfCalories calories))))
    return maxCalories

printAnswer1 :: FilePath -> IO ()
printAnswer1 path = do
    num <- getMaxCalories path
    putStrLn (show num)

printAnswer2 :: FilePath -> IO ()
printAnswer2 path = do
    num <- getTopNMaxCalories 3 path
    putStrLn (show num)