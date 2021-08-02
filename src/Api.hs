{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Api (runApi) where

import Control.Monad.IO.Class (MonadIO (liftIO))
import Data.Aeson
  ( FromJSON,
    ToJSON (toEncoding),
    defaultOptions,
    genericToEncoding,
  )
import Data.Text (Text)
import Environment (Environment (Environment, port))
import GHC.Generics (Generic)
import Run (run)
import Web.Scotty (json, post, scotty)

newtype StatusResponse = StatusResponse {status :: Text} deriving (Generic, Show)

instance ToJSON StatusResponse where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON StatusResponse

runApi :: Environment -> IO ()
runApi environment = scotty (port environment) $
  post "/" $ do
    liftIO $ do
      putStrLn "running"
      run environment
      putStrLn "done"
    json $ StatusResponse "OK"