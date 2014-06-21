import System.IO

data StudentRecord = StudentRecord String String [Int] deriving (Show)

parseStudentRecord :: String -> StudentRecord
parseStudentRecord str = StudentRecord fName lName grades
   where lName    = head parsed
         fName    = head $ drop 2 parsed
         grades   = map read (drop 3 parsed)
         parsed   = words str

finalAverage :: StudentRecord -> Int
finalAverage (StudentRecord _ _ g) = (sum g) `div` (length g)

-- main = do
--    input <- getContents
--    let records = map parseStudentRecord $ lines input
--    putStrLn "Hello world"
