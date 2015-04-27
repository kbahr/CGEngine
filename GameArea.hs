module GameArea where

  import SpoilsCore
  import Player

---- IN PLAY ----
  data InPlay = InPlay deriving Show

  instance GameArea InPlay where
    gameArea i = "In Play"
    normallyVisible InPlay _ = True

---- DECK ----
  data Deck a where
    MkDeck :: (Show a, Player a) => a -> Deck a

  instance Show (Deck a) where
    show (MkDeck a) = "Deck of " ++ (show a)

  instance GameArea (Deck a) where
    gameArea = show
    normallyVisible _ _ = False

---- OUT OF GAME ----
  data OutOfGame a where
    MkOutOfGame :: (Show a, Player a) => a -> OutOfGame a

  instance Show (OutOfGame a) where
    show (MkOutOfGame a) = "Out of game for " ++ (show a)

  instance GameArea (OutOfGame a) where
    gameArea = show
    normallyVisible _ _ = True

---- BEING PLAYED ----
  data BeingPlayed a where
    MkBeingPlayed :: (Show a, Player a) => a -> BeingPlayed a

  instance Show (BeingPlayed a) where
    show (MkBeingPlayed a) = "Being Played by " ++ (show a)

  instance GameArea (BeingPlayed a) where
    gameArea = show
    normallyVisible _ _ = True

---- HAND ----
  data Hand a where
     MkHand :: (Show a, Player a) => a -> Hand a

  instance Show (Hand a) where
    show (MkHand a) = "Hand of " ++ (show a)

  instance ContainsPlayer Hand where
    getPlayer (MkHand p) = p

  instance (Player a) => GameArea (Hand a) where
    gameArea = show
    normallyVisible h p = getPlayerId h == (getId p)
