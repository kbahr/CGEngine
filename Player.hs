module Player where

  import SpoilsCore

  data User = Human | AI

  instance Show User where
    show = getId

  instance Player User where
    getId Human = "Human Player"
    getId AI = "AI Player"
