{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Slack (sendSlackMessage) where

import Data.Aeson
  ( FromJSON,
    ToJSON (toEncoding),
    defaultOptions,
    encode,
    genericToEncoding,
  )
import Data.ByteString.Char8 (pack)
import Data.ByteString.Lazy (toStrict)
import Data.Text (Text)
import GHC.Generics (Generic)
import Network.HTTP.Conduit
  ( Request (method, requestBody, requestHeaders),
    RequestBody (RequestBodyBS),
    httpLbs,
    newManager,
    parseRequest,
    tlsManagerSettings,
  )

data Person = Person {channel :: Text, text :: Text} deriving (Generic, Show)

instance ToJSON Person where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON Person

sendSlackMessage :: String -> Text -> Text -> IO ()
sendSlackMessage token channel message = do
  request' <- parseRequest "https://slack.com/api/chat.postMessage"
  let json = encode $ Person channel message
  let headers = [("Authorization", pack $ "Bearer " ++ token), ("Content-Type", "application/json")]
  print json
  let request = request' {method = "POST", requestHeaders = headers, requestBody = RequestBodyBS $ toStrict json}
  manager <- newManager tlsManagerSettings
  res <- httpLbs request manager
  print res