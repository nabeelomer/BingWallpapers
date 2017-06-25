-- Copyright (C) Nabeel Omer 2016
-- See the LICENSE file for the license
--

import Network.HTTP.Conduit
import System.Process
import qualified Data.ByteString.Lazy.Char8 as L8
import GHC.IO.Exception

main :: IO ()
main = do
    metadata <- get "http://cdn.muzzammil.xyz/bing/bing.php?format=text&cc=IN"
    -- Guaranteed by the API
    putStrLn $ (split '>' $ (lines $ L8.unpack metadata)!!1)!!1
    let url = (lines $ L8.unpack metadata)!!0
    picture <- get $ (split '>' url)!!1
    -- All this was guaranteed by the API
    L8.writeFile "/home/nabeel/Pictures/current" picture
    exitcode <- setWallpaper "/home/nabeel/Pictures/current"
    print exitcode
    return ()

-- From StackOverflow
split :: Eq a => a -> [a] -> [[a]]
split d [] = []
split d s = x : split d (drop 1 y) where (x,y) = span (/= d) s

get :: String -> IO L8.ByteString
get url = simpleHttp url

setWallpaper :: String -> IO GHC.IO.Exception.ExitCode
setWallpaper uri = system $ "gsettings set org.gnome.desktop.background picture-uri file://" ++ uri