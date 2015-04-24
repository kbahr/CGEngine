module Core where

  class Player a where
    getId :: a -> String

  data User = Human | AI

  instance Show User where
    show = getId

  instance Player User where
    getId Human = "Human Player"
    getId AI = "AI Player"

  class GameArea a where
    name :: a -> String
    visible :: (Player p) => a -> p -> Bool

  data InPlay = InPlay deriving Show

  instance GameArea InPlay where
    name i = "In Play"
    visible InPlay _ = True

  data Deck a where
    Deck :: (Show a, Player a) => a -> Deck a

  instance Show (Deck a) where
    show (Deck a) = "Deck of " ++ (show a)

  instance GameArea (Deck a) where
    name = show
    visible _ _ = False

  data Hand a where
     Hand :: (Show a, Player a) => a -> Hand a

  instance Show (Hand a) where
    show (Hand a) = "Hand of " ++ (show a)

  player (Hand a) = a

  getPlayerId :: (Player a) => Hand a-> String
  getPlayerId h = (getId . player) h

  instance (Player a) => GameArea (Hand a) where
    name = show
    visible h p = getPlayerId h == (getId p)
