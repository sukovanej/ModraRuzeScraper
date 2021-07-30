module Main where

import Data.List
import Scraper (Day (..), Meal (..), TimeRange (..), allLunches)

main :: IO ()
main = do
  lunches <- allLunches
  putStr $ formatLunches lunches

formatLunches :: Maybe [Day] -> String
formatLunches Nothing = "Nothing :("
formatLunches (Just x) = intercalate "\n" $ map showDay x

showDay :: Day -> String
showDay (Day date (TimeRange timerange) meals) = " - " ++ date ++ "(" ++ timerange ++ ")\n" ++ showMeals meals

showMeals :: [Meal] -> String
showMeals = intercalate "\n" . map showMeal

showMeal :: Meal -> String
showMeal (Meal name price) = "  - (" ++ price ++ ") " ++ name