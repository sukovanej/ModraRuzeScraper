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
import Types (Day (..), Meal (..))

hackyFixEncoding :: T.Text -> T.Text
hackyFixEncoding = T.map encode
  where
    encode '\218' = 'Ú'
    encode '\253' = 'ý'
    encode '\232' = 'č'
    encode '\248' = 'ř'
    encode '\236' = 'ě'
    encode '\158' = 'ž'
    encode c = c

allLunches :: IO (Maybe [Day])
allLunches = scrapeURL "https://www.menicka.cz/6676-modra-ruze.html" days
  where
    days :: Scraper T.Text [Day]
    days = do
      chroots ("div" @: [hasClass "obsah"] // "div" @: [hasClass "menicka"]) day

    day :: Scraper T.Text Day
    day = do
      meals <- chroots ("ul" // "li" @: [hasClass "jidlo"]) meal
      date <- text $ "div" @: [hasClass "nadpis"]
      return $ Day (hackyFixEncoding date) meals

    meal :: Scraper T.Text Meal
    meal = do
      name <- text $ "div" @: [hasClass "polozka"]
      price <- text $ "div" @: [hasClass "cena"]
      return $ Meal (hackyFixEncoding name) (hackyFixEncoding price)