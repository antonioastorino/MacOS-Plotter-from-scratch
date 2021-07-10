#import "PLTAppDelegate.hh"
#import "PLTGlobal.hh"

@implementation PLTAppDelegate
- (void)windowWillClose:(NSNotification*)notification
{
    printf("User quit.\n");
    PLTGlobal.gAppRunning = FALSE;
}
@end