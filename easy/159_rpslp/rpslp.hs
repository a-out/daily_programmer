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

randomGesture :: IO Gesture
randomGesture = randomRIO (0, 5) >>= return . (gestureList !!)
   where gestureList = [Rock, Paper, Scissors, Lizard, Spock]

main = do
   putStrLn "Rock, Paper, Scissors, Lizard or Spock?"
   playerChoice <- getLine
   let playerGesture = (read playerChoice) :: Gesture
   computerGesture <- randomGesture
   putStrLn $ "Computer chose " ++ show computerGesture
   putStrLn $ show (playerGesture `beats` computerGesture)
