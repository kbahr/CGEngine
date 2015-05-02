module GameArea where

  import SpoilsCore
  import Player
  import Card

---- IN PLAY ----
  data InPlay p c t where
    MkInPlay :: (Card c) => [c p t] -> InPlay p c t

  instance Show (InPlay p c t) where
    show x = "In Play"

  instance GameArea InPlay where
    gameArea = show
    normallyVisible (MkInPlay _) _ = True
    getAllCards (MkInPlay cs) = cs
    getCards (MkInPlay cs) f = filter f cs
    putCard (MkInPlay cs) c = MkInPlay (c:cs)

---- DECK ----
  data Deck p c t where
    MkDeck :: (Show p, Player p, Card c) => p -> [c p t] -> Deck p c t

  instance Show (Deck p c t) where
    show (MkDeck a _) = "Deck of " ++ (show a)

  instance GameArea Deck where
    gameArea = show
    normallyVisible _ _ = False
    getAllCards (MkDeck _ cs) = cs
    getCards (MkDeck _ cs) f = filter f cs
    putCard (MkDeck p cs) c = MkDeck p (c:cs)

---- OUT OF GAME ----
  data OutOfGame p c t where
    MkOutOfGame :: (Show p, Player p, Card c) => p -> [c p t] -> OutOfGame p c t

  instance Show (OutOfGame p c t) where
    show (MkOutOfGame a _) = "Out of game for " ++ (show a)

  instance GameArea OutOfGame where
    gameArea = show
    normallyVisible _ _ = True
    getAllCards (MkOutOfGame _ cs) = cs
    getCards (MkOutOfGame _ cs) f = filter f cs
    putCard (MkOutOfGame p cs) c = MkOutOfGame p (c:cs)

---- BEING PLAYED ----
  data BeingPlayed p c t where
    MkBeingPlayed :: (Show p, Player p, Card c) => p -> [c p t] -> BeingPlayed p c t

  instance Show (BeingPlayed p c t) where
    show (MkBeingPlayed a _) = "Being Played by " ++ (show a)

  instance GameArea BeingPlayed where
    gameArea = show
    normallyVisible _ _ = True
    getAllCards (MkBeingPlayed _ cs) = cs
    getCards (MkBeingPlayed _ cs) f = filter f cs
    putCard (MkBeingPlayed p cs) c = MkBeingPlayed p (c:cs)

---- HAND ----
  data Hand p c t where
     MkHand :: (Show p, Player p, Card c) => p -> [c p t] -> Hand p c t

  instance Show (Hand p c t) where
    show (MkHand a _) = "Hand of " ++ (show a)

  extractPlayerId (MkHand p _) = getId p

  instance GameArea Hand where
    gameArea = show
    normallyVisible h p = extractPlayerId h == (getId p)
    getAllCards (MkHand _ cs) = cs
    getCards (MkHand _ cs) f = filter f cs
    putCard (MkHand p cs) c = MkHand p (c:cs)
