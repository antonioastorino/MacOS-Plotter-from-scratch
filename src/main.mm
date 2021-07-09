/* main.mm
 The main entry point to "plotter"
 */

#import "../include/PLTGenericView.hh"
#import <Cocoa/Cocoa.h>

//#import "AppDelegate.h"

static bool appRunning = TRUE;

@interface appWindowDelegate : NSWindow <NSWindowDelegate>
;
@end

@implementation appWindowDelegate
- (void)windowWillClose:(NSNotification*)notification
{
    appRunning = FALSE;
}
@end

int main(int argc, const char* argv[])
{
    FILE* log_file = fopen("/Volumes/DataMBP/plotter.log", "w");

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
    NSWindow* window = [[NSWindow alloc] initWithContentRect:windowRect
                                                   styleMask:windowStyleMask
                                                     backing:NSBackingStoreBuffered
                                                       defer:YES];

    [window setBackgroundColor:[NSColor blueColor]];
    [window makeKeyAndOrderFront:nil];
    [window setTitle:@"plotter"];

    NSRect viewFrame = NSMakeRect(0, window.contentView.frame.size.height / 2 - 1, windowRect.size.width,
                                  windowRect.size.height / 2);

    PLTGenericView* newView = [[PLTGenericView alloc] initWithFrame:viewFrame];
    [newView.layer setBackgroundColor:[NSColor colorWithCalibratedRed:1.0f
                                                                green:1.0f
                                                                 blue:1.0
                                                                alpha:1.0f]
                                          .CGColor];

    [[window contentView] addSubview:newView];
    NSLog(@"%@", [[NSApplication sharedApplication] mainWindow]);

    appWindowDelegate* windowDelegate = [[appWindowDelegate alloc] init];
    [window setDelegate:windowDelegate];

    NSEvent* event;
    while (appRunning)
    {
        do
        {
            event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                       untilDate:nil
                                          inMode:NSDefaultRunLoopMode
                                         dequeue:YES];
            if ([event type] != 0)
            {
                fprintf(log_file, "%lu ", [event type]);
                fflush(log_file);
            }
            [NSApp sendEvent:event];
        } while (event != nil);
    }
    fprintf(log_file, "%s\n", "Goodbye");
    return 0;
}