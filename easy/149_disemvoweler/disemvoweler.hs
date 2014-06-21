import Data.Char

-- My first actual haskell program.
-- I'll have to see if I can avoid the lambdas on lines
-- 9 and 10; they're unsightly. 

disemvowel :: String -> (String, String)
disemvowel phrase = (filterConsonants $ filterPunct phrase, filterVowels phrase)
   where filterConsonants xs  = filter (\x -> not $ x `elem` vowels) xs
         filterVowels xs      = filter (\ x -> x `elem` vowels) xs
         filterPunct xs       = filter isAlpha xs
         vowels = ['a', 'e', 'i', 'o', 'u']

main :: IO ()
main = do
   input <- getLine
   let disemvoweled = disemvowel input
   putStrLn $ fst disemvoweled
   putStrLn $ snd disemvoweled
