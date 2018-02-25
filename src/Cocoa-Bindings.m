//  Copyright © 2017 Nabeel Omer
//  See the LICENSE file for the license

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

bool setWallpaper() 
{
    NSString* objcstring = @("/tmp/wallpaper");
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
        if (success != 0) 
        {
            printf("%s", [[err localizedDescription] UTF8String]);
        }
        return success;
    }
}