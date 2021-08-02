{-# LANGUAGE OverloadedStrings #-}

module Main where

import Api (runApi)
import Data.Text (pack)
import Environment (Environment (Environment))
import Run (run)
import System.Environment (getArgs, getEnv)

main :: IO ()
main = do
  token <- pack <$> getEnv "SLACK_API_TOKEN"
  slackChannel <- pack <$> getEnv "SLACK_CHANNEL"
  port <- read <$> getEnv "PORT"
  args <- getArgs

  let shouldNotifySlack = "--notify-slack" `elem` args
  let shouldRunApi = "--api" `elem` args

  let environment = Environment token slackChannel shouldNotifySlack port

  if shouldRunApi
    then runApi environment
    else run environment