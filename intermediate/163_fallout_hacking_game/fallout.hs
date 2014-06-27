import Data.List
import System.Random
import Control.Applicative

correctPositions :: String -> String -> Int
correctPositions g s = length $ filter (== True) matchList
   where matchList = zipWith (==) g s

main = do
   possibleWords <- lines <$> readFile "../../files/enable1.txt"
   wordChoice <- randomRIO (0,(length possibleWords))
   let word = possibleWords !! wordChoice
   putStrLn $ show (init word)
