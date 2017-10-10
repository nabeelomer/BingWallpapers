# Bing Wallpapers

**Bing Wallpapers now works on macOS**

Fetches and applies the image of the day from Bing as the wallpaper. Works on Ubuntu and macOS.


BingWallpapers will work on most systems when run as a Cron Job.


BingWallpapers uses the [Bing Homepage API](https://github.com/muhammadmuzzammil1998/BingHomepageAPI).


For BingWallpapers on Windows see [muhammadmuzzammil1998/BingWallpaper](https://github.com/muhammadmuzzammil1998/BingWallpaper)

# Building
You need the [Haskell Stack](http://www.haskellstack.org/) tool to build BingWalpapers.

To build on Ubuntu:
Install Stack and run:
```zsh
cd Ubuntu
stack build
```

To build on macOS
```zsh
cd macOS
make
```

Eventually I'll get around to using conditional compilation.

