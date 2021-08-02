{-# LANGUAGE OverloadedStrings #-}

module Run (run) where

import Control.Monad (when)
import Data.Maybe (maybe)
import Data.Text (Text)
import Environment (Environment (Environment))
import Formatter (formatLunch)
import Scraper (allLunches)
import Slack (sendSlackMessage)
import Types (Day (Day))

getCurrentLunch :: [Day] -> Day
getCurrentLunch = head

run :: Environment -> IO ()
run (Environment token slackChannel notifySlack _) = do
  lunches <- allLunches
  let message = maybe "Kurva nejde to fetchnout :(" (formatLunch . getCurrentLunch) lunches

  putStrLn "lunches fetched"
  print message

  when notifySlack $
    do
      sendSlackMessage token slackChannel message
      putStrLn "slack notified"