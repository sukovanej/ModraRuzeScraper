{-# LANGUAGE OverloadedStrings #-}

module Formatter (formatLunches) where

import Data.Text (Text, intercalate)
import Types (Day (..), Meal (..), TimeRange (TimeRange))

formatLunches :: Maybe [Day] -> Text
formatLunches Nothing = "Nothing :("
formatLunches (Just x) = intercalate "\n" $ map showDay x

showDay :: Day -> Text
showDay (Day date (TimeRange timerange) meals) = mconcat [date, " (", timerange, ")\n", showMeals meals]

showMeals :: [Meal] -> Text
showMeals = intercalate "\n" . map showMeal

showMeal :: Meal -> Text
showMeal (Meal name price) = mconcat [" - (", price, ") ", name]