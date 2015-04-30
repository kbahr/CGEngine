module Card where

  import SpoilsCore
  import Player

  --class Card a where
  --  card :: a -> String
  --  visible :: (Player p) => a -> p -> Bool
  --  currentRole :: (Role r) => a -> r
  --  cardType :: (MacroType t) => a -> t
  --  owner :: (Player p) => a -> p
  --  controller :: (Player p) => a -> p

  --Cards always have an owner, can always be (in)visible, always have a card type
  --Controller only applies in play, current role is...?

  data OwnedCard p where
    MkOwnedCard :: (Player p) => String -> p -> OwnedCard p

  instance Named OwnedCard where
    myName = show

  instance Show (OwnedCard p) where
    show (MkOwnedCard s _) = show s

  instance ContainsPlayer OwnedCard where
    getPlayer (MkOwnedCard _ p) = p

  data TypedCard p t where
    MkTypedCard :: (ContainsPlayer c, Named c, MacroType t) => c p -> t -> TypedCard p t

  getNestedPlayer (MkTypedCard c _) = getPlayer c

  instance ContainsType (TypedCard p) where
    getType (MkTypedCard _ m) = m

  instance Show (TypedCard p t) where
    show (MkTypedCard c _) = myName c

  instance Card TypedCard where
    card = show
    owner = getNestedPlayer
    cardType = getType

  data PlayedCard c t p r where
    MkPlayedCard :: (Card c, Role r) => c p t -> p -> r -> PlayedCard c t p r

  instance Show (PlayedCard c t p r) where
    show (MkPlayedCard c _ _) = card c

  instance (MacroType t, Card c) => InPlay (PlayedCard c t) where
    currentRole (MkPlayedCard _ _ r) = r
    controller (MkPlayedCard _ p _) = p
