{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
-- |
-- Module      :  Servant.ICalendar
-- License     :  BSD-3-Clause
-- Maintainer  :  Francesco Gazzetta <francygazz@gmail.com>
--
-- An @ICalendar@ empty data type with `MimeRender` instances for `VCalendar`.
-- You should only need to import this module for it's instances and the
-- `ICalendar` datatype.:
--
-- >>> type Eg a = Get '[ICalendar] VCalendar
module Servant.ICalendar where

import Text.ICalendar.Types (VCalendar)
import Text.ICalendar.Printer (printICalendar)
import Text.ICalendar.Parser (parseICalendar)
import Data.Default (def)
import Servant.API (Accept(..), MimeRender(..), MimeUnrender(..))
import qualified Network.HTTP.Media as M
import Data.Typeable (Typeable)

data ICalendar deriving Typeable

-- | @text/calendar@
instance Accept ICalendar where
    contentType _ = "text" M.// "calendar"

-- | `printICalendar` with default settings.
instance MimeRender ICalendar VCalendar where
    mimeRender _ = printICalendar def

-- | `parseICalendar` with default settings. Returns
-- a tuple of the result and a list of warnings.
instance MimeUnrender ICalendar ([VCalendar], [String]) where
    mimeUnrender _ = parseICalendar def ""

