module GameArea where

  import SpoilsCore
  import Player

  data InPlay = InPlay deriving Show

  instance GameArea InPlay where
    gameArea i = "In Play"
    normallyVisible InPlay _ = True

  data Deck a where
    Deck :: (Show a, Player a) => a -> Deck a

  instance Show (Deck a) where
    show (Deck a) = "Deck of " ++ (show a)

  instance GameArea (Deck a) where
    gameArea = show
    normallyVisible _ _ = False

  data Hand a where
     Hand :: (Show a, Player a) => a -> Hand a

  instance Show (Hand a) where
    show (Hand a) = "Hand of " ++ (show a)

  instance ContainsPlayer Hand where
    getPlayer (Hand p) = p

  instance (Player a) => GameArea (Hand a) where
    gameArea = show
    normallyVisible h p = getPlayerId h == (getId p)
