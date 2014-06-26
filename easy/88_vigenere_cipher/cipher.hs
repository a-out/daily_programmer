import Data.Char

encrypt :: String -> String -> String
encrypt p k = zipWith forward p (cycle k)

charValue :: Char -> Int
charValue a = (ord . toLower) a - 97

forward :: Char -> Char -> Char
forward a b = chr $ ((charValue a + charValue b) `mod` 26) + 97

main = do
   plaintext <- getLine
   key <- getLine
   putStrLn $ encrypt plaintext key
