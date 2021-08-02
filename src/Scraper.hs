{-# LANGUAGE OverloadedStrings #-}

module Scraper (allLunches) where

import qualified Data.Text as T
import Text.HTML.Scalpel
  ( Scraper,
    chroots,
    hasClass,
    scrapeURL,
    text,
    (//),
    (@:),
  )
import Types (Day (..), Meal (..), TimeRange (..))

-- selector : #menicka > div > div.text > div.profile > div.obsah > div:nth-child(3)
--

convertToTimeRange :: T.Text -> TimeRange
convertToTimeRange = TimeRange . T.drop 6

allLunches :: IO (Maybe [Day])
allLunches = scrapeURL "https://www.menicka.cz/6676-modra-ruze.html" days
  where
    days :: Scraper T.Text [Day]
    days = do
      chroots ("div" @: [hasClass "menicka"]) day

    day :: Scraper T.Text Day
    day = do
      timerange <- text $ "div" @: [hasClass "obedovycas"]
      meals <- chroots ("ul" // "li" @: [hasClass "jidlo"]) meal
      date <- text $ "div" @: [hasClass "nadpis"]
      return $ Day date (convertToTimeRange timerange) meals

    meal :: Scraper T.Text Meal
    meal = do
      name <- text $ "div" @: [hasClass "polozka"]
      price <- text $ "div" @: [hasClass "cena"]
      return $ Meal name price
