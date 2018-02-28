extern crate reqwest;

use std::fs::File;
use std::io::prelude::*;
use std::process::Command;
use std::env;
use std::ffi::CString;

fn main() {
    if let Ok(mut response) =
        // using https://git.muzzammil.xyz/bing/
        reqwest::get("https://cdn.muzzammil.xyz/bing/bing.php?format=text&cc=AU&hs")
    {
        let text = response.text().unwrap();
        // Guaranteed by the API so unwrap() is ok.
        let mut metadata = text.split("\n").collect::<Vec<&str>>();
        let searchlink = metadata.pop().unwrap().split(">").collect::<Vec<&str>>();
        let copyrightdata = metadata.pop().unwrap().split(">").collect::<Vec<&str>>();
        let url = metadata.pop().unwrap().split(">").collect::<Vec<&str>>();

        if let Ok(mut image) = reqwest::get(url[1]) {
            if let Some(mut path) = env::home_dir() {
                path.push("wallpaper.jpg");
                let mut file = File::create(path).unwrap();
                image.copy_to(&mut file).expect("Failed to save image!");
            }
        } else {
            println!("Unable to download image!");
        }

        set_wallpaper();

        println!(
            "BingWallpapers {}\n{}\n{}",
            env!("CARGO_PKG_VERSION"),
            copyrightdata[1],
            searchlink[1]
        );
    } else {
        println!("Unable to connect to bing!");
    }
}

#[cfg(target_os = "macos")]
fn set_wallpaper() {
    if let Some(mut path) = env::home_dir() {
        path.push("wallpaper.jpg");
        unsafe { setWallpaper(CString::new(path.to_str().unwrap()).unwrap()) };
    }
}

#[cfg(target_os = "linux")]
fn set_wallpaper() {
    Command::new("gsettings")
        .args(&[
            "set",
            "org.gnome.desktop.background",
            "picture-uri",
            "file:///tmp/wallpaper",
        ])
        .output()
        .expect("Failed to apply wallpaper!")
}

#[cfg(target_os = "macos")]
#[link(name = "Cocoa-Bindings", kind = "static")]
extern "C" {
    fn setWallpaper(path: CString) -> i32;
}
