package main

import (
  "fmt"
  "io"
  "io/ioutil"
  "net/http"
  "os"
  "os/exec"
  "strings"
  "runtime"
)

func main() {
  if runtime.GOOS == "windows" {
    fmt.Println("What are you trying to do, huh?")
  } else if runtime.GOOS == "darwin"{
    fmt.Println("Siri-ously?")
  } else {
    rawURL := BingHomepageAPI("US");
    fileName := "/home/muzzammil/Pictures/BingWallpaper.jpg"
    file, err := os.Create(fileName)
    if err != nil { panic(err) }
    defer file.Close()
    resp, err := http.Get(rawURL)
    if err != nil { panic(err) }
    defer resp.Body.Close()
    fmt.Println(resp.Status)
    io.Copy(file, resp.Body)
    exec.Command("/usr/bin/gsettings", "set", "org.gnome.desktop.background", "picture-uri", "file://" + fileName).Run()
  }
}
func BingHomepageAPI(countryCode string) (string) { 
  api := "http://cdn.muzzammil.xyz/bing/bing.php?lang=go&format=text&cc=" + countryCode
  resp, err := http.Get(api)
  defer resp.Body.Close()
  bingData, err := ioutil.ReadAll(resp.Body)
  if err != nil { panic(err) }
  return strings.Split(strings.Split(string(bingData), "\n")[0], ">")[1]
}
