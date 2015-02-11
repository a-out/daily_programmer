type Coordinate = (Int, Int)
data EntityType = Tree | Lumberjack | Bear deriving (Show, Enum, Eq, Read)
data ForestEntity = Entity EntityType Coordinate deriving (Show, Eq)

forest :: [Char]
forest = replicate 100 '.'

main = do
   putStrLn forest