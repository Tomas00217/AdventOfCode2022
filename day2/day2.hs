calculateTotalScore :: (String -> String -> Integer) -> FilePath -> IO ()
calculateTotalScore f path = do
    contents <- readFile path
    let totalScore = sum (map (calculateRound f) (lines contents))
    print totalScore

calculateRound :: (String -> String -> Integer) -> String -> Integer
calculateRound f s = let xs = words s
    in f (head xs) (last xs)

getRoundScore :: String -> String -> Integer
getRoundScore "A" s
    | s == "X" = 4
    | s == "Y" = 8
    | s == "Z" = 3
getRoundScore "B" s
    | s == "X" = 1
    | s == "Y" = 5
    | s == "Z" = 9
getRoundScore "C" s
    | s == "X" = 7
    | s == "Y" = 2
    | s == "Z" = 6

getRoundScoreDecrypted :: String -> String -> Integer
getRoundScoreDecrypted "A" s
    | s == "X" = 3
    | s == "Y" = 4
    | s == "Z" = 8
getRoundScoreDecrypted "B" s
    | s == "X" = 1
    | s == "Y" = 5
    | s == "Z" = 9
getRoundScoreDecrypted "C" s
    | s == "X" = 2
    | s == "Y" = 6
    | s == "Z" = 7

printAnswer1 :: FilePath -> IO ()
printAnswer1 = calculateTotalScore getRoundScore

printAnswer2 :: FilePath -> IO ()
printAnswer2 = calculateTotalScore getRoundScoreDecrypted