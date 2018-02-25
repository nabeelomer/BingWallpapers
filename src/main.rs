extern crate reqwest;

use std::fs::File;
use std::io::prelude::*;
use std::process::Command;

fn main() {
    if let Ok(mut response) =
        reqwest::get("https://cdn.muzzammil.xyz/bing/bing.php?format=text&cc=AU&hs")
    {
        let text = response.text().unwrap();
        // Guaranteed by the API so unwrap() is ok.
        let mut metadata = text.split("\n").collect::<Vec<&str>>();
        let searchlink = metadata.pop().unwrap().split(">").collect::<Vec<&str>>();
        let copyrightdata = metadata.pop().unwrap().split(">").collect::<Vec<&str>>();
        let url = metadata.pop().unwrap().split(">").collect::<Vec<&str>>();

        if let Ok(mut image) = reqwest::get(url[1]) {
            let mut file = File::create("/tmp/wallpaper").unwrap();
            image.copy_to(&mut file).expect("Failed to save image!");
        } else {
            println!("Unable to download image!");
        }

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
    let status = unsafe { setWallpaper() };
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

#[link(name = "Cocoa-Bindings", kind = "static")]
extern "C" {
    fn setWallpaper() -> i32;
}
