//  Copyright © 2017 Nabeel Omer
//  See the LICENSE file for the license

@import AppKit;

bool setWallpaper(char* path) 
{
    NSString* objcstring = @(path);
    @autoreleasepool {
        NSWorkspace *sw = [NSWorkspace sharedWorkspace];
        NSScreen *screen = [NSScreen screens].firstObject;
        NSMutableDictionary *so = [[sw desktopImageOptionsForScreen:screen] mutableCopy];
        NSError *err;
        bool success = [sw
                        setDesktopImageURL:[NSURL fileURLWithPath:objcstring]
                        forScreen:screen
                        options:so
                        error:&err];
        if (success != true) 
        {
            printf("%s", [[err localizedDescription] UTF8String]);
        }
        return success;
    }
}