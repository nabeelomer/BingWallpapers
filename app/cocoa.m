//
//  main.m
//  BingWallpapers-Mac
//
//  Created by Nabeel Omer on 25/07/17.
//  Copyright © 2017 Nabeel Omer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <Appkit/AppKit.h>
#import <CoreWLAN/CoreWLAN.h>

int setWallpaper(char* path) {
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
        return 0;
    }
}
