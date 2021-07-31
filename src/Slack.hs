{-# LANGUAGE OverloadedStrings #-}

module Slack (sendSlackMessage) where

import Data.ByteString.Char8 (pack)
import Network.HTTP.Conduit

sendSlackMessage :: String -> String -> String -> IO ()
sendSlackMessage token channel message = do
  request' <- parseRequest "https://slack.com/api/chat.postMessage"
  let json = "{channel: \"" ++ channel ++ "\", text: \"" ++ message ++ "\"}"
  print json
  let request =
        request'
          { method = "POST",
            requestHeaders = [("Authorization", pack $ "Bearer " ++ token), ("Content-Type", "application/json")],
            requestBody = RequestBodyBS . pack $ json
          }
  manager <- newManager tlsManagerSettings
  res <- httpLbs request manager
  print res
