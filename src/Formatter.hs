{-# LANGUAGE OverloadedStrings #-}

module Formatter (formatLunch) where

import Data.Text (Text, intercalate, pack)
import Types (Day (..), Meal (..))

formatLunch :: Day -> Text
formatLunch (Day date meals) = mconcat [date, "\n", showMeals meals]

showMeals :: [Meal] -> Text
showMeals = intercalate "\n" . map showMeal

showMeal :: Meal -> Text
showMeal (Meal name price) = mconcat [" - (", price, ") ", name]