{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text (Text, intercalate)
import Types (Day (..), Meal (..), TimeRange (..), )
import Formatter (formatLunches)
import Scraper (allLunches)
import Slack (sendSlackMessage)
import System.Environment (getEnv)

main :: IO ()
main = do
  token <- getEnv "SLACK_API_TOKEN"
  lunches <- allLunches
  let formattedLunches = formatLunches lunches
  putStrLn "lunches fetched"
  print formattedLunches
  -- sendSlackMessage token "gay-sex" formattedLunches
  -- putStrLn "slack notified"