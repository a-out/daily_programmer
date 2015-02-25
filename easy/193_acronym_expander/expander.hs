import Control.Applicative
import System.IO
import Data.List.Split (splitOn)
import Data.List
import qualified Data.Map as Map

readAcronymList = Map.fromList . map (toTup . splitOn " - ") . lines <$> readFile "acronyms.txt"
   where toTup [x,y] = (x, y)

substituteAcronyms a s = intercalate " " . map sub $ words s
   where sub w = Map.findWithDefault w w a

main = do
   sentence <- getContents
   acronyms <- readAcronymList
   let subbed = substituteAcronyms acronyms sentence
   print subbed