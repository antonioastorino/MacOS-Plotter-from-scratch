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
    CGRect screenRect = [[NSScreen mainScreen] frame];

    // Create a rect object to save position and size of the window we are creating
    CGRect windowRect = NSMakeRect(screenRect.size.width / 4.0f, screenRect.size.height / 4.0f,
                                    screenRect.size.width / 2.0f, screenRect.size.height / 2.0f);

    // Set window style parameters
    NSWindowStyleMask windowStyleMask = NSWindowStyleMaskClosable | NSWindowStyleMaskTitled;

    // https://stackoverflow.com/questions/15694510/programmatically-create-initial-window-of-cocoa-app-os-x

    NSApplication* myApplication = [NSApplication sharedApplication];

    NSWindow* window = [[PLTWindow alloc] initWithContentRect:windowRect
                                                    styleMask:windowStyleMask
                                                      backing:NSBackingStoreBuffered
                                                        defer:YES];

    [window setBackgroundColor:[NSColor systemGrayColor]];
    [window makeKeyAndOrderFront:nil];
    [window setTitle:@"plotter"];

    CGRect viewFrame = NSMakeRect(0, window.contentView.bounds.size.height / 2 - 1,
                                   window.contentView.bounds.size.width,
                                   window.contentView.bounds.size.height / 2);

    PLTGenericView* topView = [[PLTGenericView alloc] initWithFrame:viewFrame];
    [topView addOffset:5.0f];
    [topView.layer setBackgroundColor:[NSColor blackColor].CGColor];

    [[window contentView] addSubview:topView];

    PLTAppDelegate* windowDelegate = [[PLTAppDelegate alloc] init];
    [window setDelegate:windowDelegate];

    PLTApplication* applicationObj = [[PLTApplication alloc] init];
    if (![applicationObj loadPoints:@"path/to/file"])
    {
        exit(1);
    }
    [topView setPoints:applicationObj];

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

        [topView setNeedsDisplay:YES];
        [NSApp sendEvent:event];
    }
    LOG_INFO("Goodbye");
    return 0;
}