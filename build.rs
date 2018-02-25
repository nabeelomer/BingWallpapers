extern crate cc;

fn main() {
    if cfg!(target_os = "macos") {
        cc::Build::new()
        .file("src/Cocoa-Bindings.m")
        .flag_if_supported("-framework Cocoa")
        .flag_if_supported("-fobjc-arc")
        .flag_if_supported("-fmodules")
        .flag_if_supported("-mmacosx-version-min=10.13")
        .compile("Cocoa-Bindings");
    }
}
