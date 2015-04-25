module Action where

  import SpoilsCore

  data PlayCard a where
    PlayCard :: (Show a, Player a) => a -> PlayCard a

  data UseAbility a where
    UseAbility :: (Show a, Player a) => a -> UseAbility a

  data Attack a where
    Attack :: (Show a, Player a) => a -> Attack a

  data EndTurn a where
    EndTurn :: (Show a, Player a) => a -> EndTurn a

  instance (Player a) => Action (UseAbility a) where
    action = show
    isActing a p = getPlayerId a == (getId p)

  instance Show (UseAbility a) where
    show (UseAbility a) = (show a) ++ " is using an ability"

  instance ContainsPlayer UseAbility where
    getPlayer (UseAbility a) = a

  instance (Player a) => Action (PlayCard a) where
    action = show
    isActing a p = getPlayerId a == (getId p)

  instance Show (PlayCard a) where
    show (PlayCard a) = (show a) ++ " is using playing a card"

  instance ContainsPlayer PlayCard where
    getPlayer (PlayCard a) = a

  instance (Player a) => Action (Attack a) where
    action = show
    isActing a p = getPlayerId a == (getId p)

  instance Show (Attack a) where
    show (Attack a) = (show a) ++ " is attacking"

  instance ContainsPlayer Attack where
    getPlayer (Attack a) = a

  instance (Player a) => Action (EndTurn a) where
    action = show
    isActing a p = getPlayerId a == (getId p)

  instance Show (EndTurn a) where
    show (EndTurn a) = (show a) ++ " is ending their turn"

  instance ContainsPlayer EndTurn where
    getPlayer (EndTurn a) = a
