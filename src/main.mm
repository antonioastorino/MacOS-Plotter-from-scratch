/* main.mm
 The main entry point to "plotter"
 */

#import "PLTAppDelegate.hh"
#import "PLTApplication.hh"
#import "PLTGenericView.hh"
#import "PLTGlobal.hh"
#import "PLTWindow.hh"
#include "c/logger.h"
#import <Cocoa/Cocoa.h>
#include <os/log.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, const char* argv[])
{

    PLTGlobal.gAppRunning = TRUE;
    // Getting the user's Lib folder
    NSString* userLibFolder =
        [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)
            objectAtIndex:0];

    const char* userLibFolderStr = userLibFolder.UTF8String;
    const char* appLogPath       = strcat((char*)userLibFolderStr, "/Logs/plotter.log");
    init_logger(appLogPath, appLogPath);
    LOG_INFO("Logger initialized!");

    // Retrieve the screen coordinates of the main screen
    NSRect screenRect = [[NSScreen mainScreen] frame];

    // Create a rect object to save position and size of the window we are creating
    NSRect windowRect = NSMakeRect(screenRect.size.width / 4.0f, screenRect.size.height / 4.0f,
                                   screenRect.size.width / 2.0f, screenRect.size.height / 2.0f);

    // Set window style parameters
    NSWindowStyleMask windowStyleMask = NSWindowStyleMaskClosable | NSWindowStyleMaskTitled;

    // https://stackoverflow.com/questions/15694510/programmatically-create-initial-window-of-cocoa-app-os-x

    NSApplication* myApplication = [NSApplication sharedApplication];

    // Create a window
    // https://stackoverflow.com/questions/314256/how-do-i-create-a-cocoa-window-programmatically
    NSWindow* window = [[PLTWindow alloc] initWithContentRect:windowRect
                                                    styleMask:windowStyleMask
                                                      backing:NSBackingStoreBuffered
                                                        defer:YES];

    [window setBackgroundColor:[NSColor blueColor]];
    [window makeKeyAndOrderFront:nil];
    [window setTitle:@"plotter"];

    NSRect viewFrame = NSMakeRect(0, window.contentView.bounds.size.height / 2 - 1,
                                  window.contentView.bounds.size.width,
                                  window.contentView.bounds.size.height / 2);

    PLTGenericView* newView = [[PLTGenericView alloc] initWithFrame:viewFrame];
    [newView.layer setBackgroundColor:[NSColor colorWithCalibratedRed:1.0f
                                                                green:1.0f
                                                                 blue:1.0
                                                                alpha:1.0f]
                                          .CGColor];

    [[window contentView] addSubview:newView];

    PLTAppDelegate* windowDelegate = [[PLTAppDelegate alloc] init];
    [window setDelegate:windowDelegate];

    PLTApplication* applicationObj = [[PLTApplication alloc] init];
    if (![applicationObj loadPoints:@"path/to/file"])
    {
        exit(1);
    }
    [newView setPoints:applicationObj];

    NSEvent* event;
    uint color = 0;

    while (PLTGlobal.gAppRunning)
    {

        event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                   untilDate:[NSDate distantFuture]
                                      inMode:NSDefaultRunLoopMode
                                     dequeue:YES];
        if ([event type] != 0)
        {

            LOG_TRACE("%lu", [event type]);
        }
        if ([event type] == NSEventTypeLeftMouseDown)
        {
            LOG_TRACE("Mouse down");
        }
        CGFloat floatColor = (CGFloat)color / 256.0f;
        [newView setSomeColor:floatColor];
        [newView setNeedsDisplay:YES];
        [NSApp sendEvent:event];
        color = (color + 1) % 256;
    }
    LOG_INFO("Goodbye");
    return 0;
}