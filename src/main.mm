/* main.mm
 The main entry point to "plotter"
 */

#import "PLTAppDelegate.hh"
#import "PLTApplication.hh"
#import "PLTGenericView.hh"
#import "PLTGlobal.hh"
#import "PLTPopUpButton.hh"
#import "PLTWindow.hh"
#include "definitions.h"
#include "logger.h"
#import <Cocoa/Cocoa.h>
#include <os/log.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, const char* argv[])
{

    PLTGlobal.gAppRunning = TRUE;

    PLTApplication* applicationObj = [[PLTApplication alloc] init];

    NSEvent* event;
    while (PLTGlobal.gAppRunning)
    {
        event = [[NSApplication sharedApplication] nextEventMatchingMask:NSEventMaskAny
                                                               untilDate:[NSDate distantFuture]
                                                                  inMode:NSDefaultRunLoopMode
                                                                 dequeue:YES];

        [applicationObj update:event];

        [NSApp sendEvent:event];
    }
    LOG_INFO("Goodbye");
    return 0;
}