module Types (TimeFrom, TimeTo, Meal (..), Date, Day (..)) where

import Data.Text (Text)

type TimeFrom = Int

type TimeTo = Int

type MealName = Text

type MealPrice = Text -- TODO: to number

data Meal = Meal MealName MealPrice
  deriving (Show, Eq)

type Date = Text

data Day = Day Date [Meal]
  deriving (Show, Eq)
