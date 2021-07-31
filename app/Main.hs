module Main where

import Data.List
import Scraper (Day (..), Meal (..), TimeRange (..), allLunches)
import Slack (sendSlackMessage)
import System.Environment

main :: IO ()
main = do
  token <- getEnv "SLACK_API_TOKEN"
  putStrLn "token fetched"
  lunches <- allLunches
  let formattedLunches = formatLunches lunches
  putStrLn formattedLunches
  putStrLn "lunches fetched"
  sendSlackMessage token "gay-sex" formattedLunches
  putStrLn "slack notified"

formatLunches :: Maybe [Day] -> String
formatLunches Nothing = "Nothing :("
formatLunches (Just x) = intercalate "\n" $ map showDay x

showDay :: Day -> String
showDay (Day date (TimeRange timerange) meals) = " - " ++ date ++ "(" ++ timerange ++ ")\n" ++ showMeals meals

showMeals :: [Meal] -> String
showMeals = intercalate "\n" . map showMeal

showMeal :: Meal -> String
showMeal (Meal name price) = "  - (" ++ price ++ ") " ++ name
