module Environment (Environment (Environment, slackChannel, slackToken, notifySlack, port)) where

import Data.Text (Text)

data Environment = Environment
  { slackChannel :: Text,
    slackToken :: Text,
    notifySlack :: Bool,
    port :: Int
  }