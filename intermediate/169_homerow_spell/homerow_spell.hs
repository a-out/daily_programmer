import Data.List
import Data.Char
import System.IO
import Data.Maybe
import Control.Applicative

row_t = "qwertyuiop"
row_m = "asdfghjkl"
row_b = "zxcvbnm"

spellCheck :: [String] -> String -> String
spellCheck wordList word = case word `elem` wordList of
   True -> word
   False -> head $ filter (isWord wordList) wordPossibilities
   where wordPossibilities = map (shift word) [-2..2]

isWord :: [String] -> String -> Bool
isWord wordList word = word `elem` wordList

shift :: String -> Int -> String
shift word n = map (shiftChar n) word

shiftChar :: Int -> Char -> Char
shiftChar n c = r !! abs ((index + n) `mod` (length r))
   where index = fromMaybe 0 $ elemIndex c (row c)
         r = row c

row :: Char -> String
row c
   | c `elem` row_t = row_t
   | c `elem` row_m = row_m
   | otherwise = row_b

main = do
   input <- words <$> getContents
   let inputWords = map (filter isAlpha . (map toLower)) input
   dictFile <- openFile "../../files/enable1.txt" ReadMode
   wordList <- words <$> hGetContents dictFile
   let checkedWords = map (spellCheck wordList) inputWords
   putStrLn $ unwords checkedWords
