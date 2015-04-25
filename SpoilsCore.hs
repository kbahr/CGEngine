module SpoilsCore where

  class ContainsPlayer c where
    getPlayer :: (Player p) => c p -> p
    getPlayerId :: (Player p) => c p -> String
    getPlayerId = (getId . getPlayer)

  class Player a where
    getId :: a -> String

  class GameArea a where
    gameArea :: (GameArea a) => a -> String
    normallyVisible :: (Player p) => a -> p -> Bool

  class Role a where
    role :: a -> String

  class MacroType a where
    macroType :: a -> String

  class Card a where
    card :: a -> String
    visible :: (Player p) => a -> p -> Bool
    currentRole :: (Role r) => a -> r
    cardType :: (MacroType t) => a -> t
    owner :: (Player p) => a -> p
    controller :: (Player p) => a -> p

  class Action a where
    action :: a -> String
    isActing :: (Player p) => a -> p -> Bool

  data Trade = Banker | Warlord | Rogue | Gearsmith | Arcanist

  data Icon = Greed | Rage | Deception | Elitism | Obsession | Volition

  data GameState a where
    StartingGame :: (Player a) => a -> GameState a
    StartingTurn :: (Player a) => a -> GameState a
    DuringTurn :: (Player a) => a -> GameState a
    PlayingCard :: (Player a) => a -> GameState a
    UsingAbility :: (Player a) => a -> GameState a
    DeclaringAttack :: (Player a) => a -> GameState a
    EndingTurn :: (Player a) => a -> GameState a
