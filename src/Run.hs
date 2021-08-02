module Run (run) where

import Control.Monad (when)
import Data.Text (Text)
import Environment (Environment (Environment))
import Formatter (formatLunches)
import Scraper (allLunches)
import Slack (sendSlackMessage)

run :: Environment -> IO ()
run (Environment token slackChannel notifySlack _) = do
  lunches <- allLunches
  let formattedLunches = formatLunches lunches
  putStrLn "lunches fetched"
  print formattedLunches

  when notifySlack $
    do
      sendSlackMessage token slackChannel formattedLunches
      putStrLn "slack notified"