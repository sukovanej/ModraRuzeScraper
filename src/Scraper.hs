{-# LANGUAGE OverloadedStrings #-}

module Scraper
  ( allLunches,
    TimeFrom,
    TimeTo,
    TimeRange (..),
    MealName,
    MealPrice,
    Meal (..),
    Date,
    Day (..),
  )
where

import Text.HTML.Scalpel
  ( Scraper,
    chroots,
    hasClass,
    scrapeURL,
    text,
    (//),
    (@:),
  )

type TimeFrom = Int

type TimeTo = Int

data TimeRange = TimeRange String -- TimeRange TimeFrom TimeTo
  deriving (Show, Eq)

type MealName = String

type MealPrice = String -- TODO: to string

data Meal = Meal MealName MealPrice
  deriving (Show, Eq)

type Date = String

data Day = Day Date TimeRange [Meal]
  deriving (Show, Eq)

-- selector : #menicka > div > div.text > div.profile > div.obsah > div:nth-child(3)
--

convertToTimeRange :: String -> TimeRange
convertToTimeRange = TimeRange

allLunches = scrapeURL "https://www.menicka.cz/6676-modra-ruze.html" days
  where
    days :: Scraper String [Day]
    days = do
      chroots ("div" @: [hasClass "menicka"]) day

    day :: Scraper String Day
    day = do
      timerange <- text $ "div" @: [hasClass "obedovycas"]
      meals <- chroots ("ul" // "li" @: [hasClass "jidlo"]) meal
      date <- text $ "div" @: [hasClass "nadpis"]
      return $ Day date (convertToTimeRange timerange) meals

    meal :: Scraper String Meal
    meal = do
      name <- text $ "div" @: [hasClass "polozka"]
      price <- text $ "div" @: [hasClass "cena"]
      return $ Meal name price
