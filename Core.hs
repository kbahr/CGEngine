module Core where

  class Player a where
    getId :: a -> String

  data User = Human | AI deriving Show

  instance Player User where
    getId Human = "Human Player"
    getId AI = "AI Player"

  class Player b => GameArea a b where
    name :: a -> String
    visible :: a -> b -> Bool

  data InPlay = InPlay deriving Show

  instance GameArea InPlay b where
    name i = "In Play"
    visible i _ = True

  --data Player a => Hand a = Hand a {getPlayer :: Hand -> a} deriving Show

  --getPlayerId :: Hand -> String
  --getPlayerId h = getId . getPlayer h

  --instance GameArea Hand b where
  --  name h = "hand"
  --  visible h p = getPlayerId h == (getId p)
