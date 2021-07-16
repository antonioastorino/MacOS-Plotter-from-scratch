#import "PLTAppDelegate.hh"
#import "PLTGlobal.hh"
#include "logger.h"

@implementation PLTAppDelegate
- (void)windowWillClose:(NSNotification*)notification
{
    LOG_INFO("User quit.");
    PLTGlobal.gAppRunning = FALSE;
}
@end