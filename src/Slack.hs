{-# LANGUAGE OverloadedStrings #-}

module Slack (sendSlackMessage) where

import Control.Monad.Reader (ReaderT (runReaderT))
import Data.Text (Text)
import Web.Slack (chatPostMessage, mkSlackConfig)
import Web.Slack.Chat (PostMsgRsp, mkPostMsgReq)
import Web.Slack.Common (SlackClientError)

sendSlackMessage :: Text -> Text -> Text -> IO (Either SlackClientError PostMsgRsp)
sendSlackMessage token channel message = do
  slackConfig <- mkSlackConfig token
  runReaderT (chatPostMessage $ mkPostMsgReq channel message) slackConfig