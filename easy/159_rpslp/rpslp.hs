import Control.Applicative
import System.Random
import Data.List
import Data.Map as Map
import Data.Maybe

data Choice = Rock | Paper | Scissors | Lizard | Spock
   deriving (Eq, Bounded, Ord, Enum, Read, Show)

data Outcome = Win | Lose | Draw
   deriving (Eq, Show)

-- make choice at random
randomChoice :: IO Choice
randomChoice = toEnum <$> randomRIO (lower, upper)
   where lower = fromEnum (minBound :: Choice)
         upper = fromEnum (maxBound :: Choice)

choices :: [Choice]
choices = [(minBound :: Choice)..]

combat :: Map Choice [Choice]
combat = Map.fromList [
      (Rock, [Lizard, Scissors]),
      (Paper, [Rock, Spock]),
      (Scissors, [Paper, Lizard]),
      (Lizard, [Spock, Paper]),
      (Spock, [Scissors, Rock])
   ]

fight :: Choice -> Choice -> Outcome
fight x y
   | x == y                   = Draw
   | fight' x y == Just True  = Win
   | otherwise                = Lose
   where losers a = Map.lookup a combat
         fight' x y = elem y <$> losers x

main = do
   putStrLn $ "Choose from " ++ intercalate ", " (Data.List.map show choices)
   input <- getLine
   computerChoice <- randomChoice
   let playerChoice = (read input) :: Choice
   putStrLn $ "You choose: " ++ (show playerChoice)
   putStrLn $ "Computer chooses: " ++ (show computerChoice)
   putStrLn . show $ fight playerChoice computerChoice