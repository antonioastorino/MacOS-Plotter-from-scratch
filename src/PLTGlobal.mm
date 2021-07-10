#import "PLTGlobal.hh"

@implementation PLTGlobal
static bool gAppRunning;
+ (bool)gAppRunning;
{
    @synchronized(self)
    {
        return gAppRunning;
    }
}
+ (void)setGAppRunning:(bool)val
{
    @synchronized(self)
    {
        gAppRunning = val;
    }
}
@end