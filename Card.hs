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

  data GenericCard n p where
    MkGenericCard :: (Player p) => String -> p -> GenericCard String p

  instance (Show n) => Show (GenericCard n p) where
    show (MkGenericCard n p) = show n

  instance ContainsPlayer (GenericCard n) where
    getPlayer (MkGenericCard _ p) = p

  data TypedCard c t where
    MkTypedCard :: (ContainsPlayer c, MacroType t) => c p -> t -> TypedCard c t

  instance ContainsType (TypedCard c) where
    getType (MkTypedCard _ m) = m

  instance Show (TypedCard c t) where
    show (MkTypedCard c _) = show c

  instance (ContainsPlayer c, MacroType m) => Card (TypedCard c m) where
    card = show
    owner (MkTypedCard c _) = getPlayer c
    cardType = getType
