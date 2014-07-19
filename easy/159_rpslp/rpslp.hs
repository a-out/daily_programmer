import qualified Data.Map as Map
import System.Random

data Gesture = Rock | Paper | Scissors | Lizard | Spock deriving (Show, Read, Eq, Enum, Ord)

beats :: Gesture -> Gesture -> Maybe Bool
beats x y = Map.lookup x beatsMap >>= \l -> return (y `elem` l)
   where beatsMap = Map.fromList [(Rock, [Scissors, Lizard]),
                                  (Paper, [Rock, Spock]),
                                  (Scissors, [Paper, Lizard]),
                                  (Lizard, [Spock, Paper]),
                                  (Spock, [Rock, Scissors])
                                 ]

main = do
   playerChoice <- getLine
   let playerGesture = (read playerChoice) :: Gesture
   putStrLn $ show playerGesture
