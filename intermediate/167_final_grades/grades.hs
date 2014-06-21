import System.IO
import Data.Char

data Grade = Grade Int
data StudentRecord = StudentRecord String String [Grade]

parseStudentRecord :: String -> StudentRecord
parseStudentRecord str = StudentRecord fName lName grades
   where lName    = head parsed
         fName    = head $ drop 2 parsed
         grades   = map (Grade . strToInt) (drop 2 parsed)
         parsed   = words str
         strToInt s = s :: Int

main = do
   input <- getContents
   putStrLn "Hello world"
