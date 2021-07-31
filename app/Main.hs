{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text (Text, intercalate)
import Formatter (formatLunches)
import Scraper (allLunches)
import Slack (sendSlackMessage)
import System.Environment (getEnv, getArgs)
import Types (Day (..), Meal (..), TimeRange (..))
import Control.Monad (when)

main :: IO ()
main = do
  token <- getEnv "SLACK_API_TOKEN"
  args <- getArgs
  lunches <- allLunches
  let formattedLunches = formatLunches lunches
  putStrLn "lunches fetched"
  print formattedLunches

  when ("--notify-slack" `elem` args) $
    do
      sendSlackMessage token "gay-sex" formattedLunches
      putStrLn "slack notified"