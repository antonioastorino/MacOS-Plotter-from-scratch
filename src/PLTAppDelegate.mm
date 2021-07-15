#import "PLTAppDelegate.hh"
#import "PLTGlobal.hh"
#include "c/logger.h"

@implementation PLTAppDelegate
- (void)windowWillClose:(NSNotification*)notification
{
    LOG_INFO("User quit.");
    PLTGlobal.gAppRunning = FALSE;
}
@end