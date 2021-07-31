module Types (TimeFrom, TimeTo, TimeRange (..), Meal (..), Date, Day (..)) where

import Data.Text (Text)

type TimeFrom = Int

type TimeTo = Int

data TimeRange = TimeRange Text -- TimeRange TimeFrom TimeTo
  deriving (Show, Eq)

type MealName = Text

type MealPrice = Text -- TODO: to string

data Meal = Meal MealName MealPrice
  deriving (Show, Eq)

type Date = Text

data Day = Day Date TimeRange [Meal]
  deriving (Show, Eq)
