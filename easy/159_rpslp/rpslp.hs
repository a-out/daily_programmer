
data Gesture = Rock | Paper | Scissors | Lizard | Spock deriving (Show, Read, Enum)

combatMap :: EnumMap Gesture Gesture
combatMap = fromList [(fromEnum Paper, fromEnum Rock)]
