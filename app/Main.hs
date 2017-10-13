-- Copyright (C) Nabeel Omer 2017
-- See the LICENSE file for the license

{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CPP #-}

import Network.HTTP.Conduit
import System.Process
import qualified Data.ByteString.Lazy.Char8 as L8
import GHC.IO.Exception
import Data.List.Split
import Control.Monad
import System.Environment
import Paths_BingWallpapers
import Data.Version (showVersion)

#if defined(darwin_HOST_OS)
{-# OPTIONS_GHC Cocoa-Calls.o #-}
foreign import ccall "setWallpaper" setWallpaper :: IO Int
#elif defined(linux_HOST_OS)
setWallpaper :: IO GHC.IO.Exception.ExitCode
setWallpaper = system $ "gsettings set org.gnome.desktop.background picture-uri file://"
#endif

main :: IO ()
main = do
    putStrLn $ "Bing Wallpapers v" ++ showVersion version
    -- using http://muzzammil.xyz/git/bing/
    -- from https://codereview.stackexchange.com/a/166766/142027
    (_:url:_):(_:title:_):_ <- map (wordsBy (=='>')) . lines . L8.unpack <$> get "https://cdn.muzzammil.xyz/bing/bing.php?format=text&cc=AU&hs"
    putStrLn title
    L8.writeFile "/tmp/wallpapers" =<< get url
    print =<< setWallpaper
-- From https://stackoverflow.com/a/24792141/8207187
-- split :: Eq a => a -> [a] -> [[a]]
-- split d [] = []
-- split d s = x : split d (drop 1 y) where (x,y) = span (/= d) s
get :: String -> IO L8.ByteString
get url = simpleHttp url
