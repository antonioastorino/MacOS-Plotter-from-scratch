#ifndef PLT_GLOBAL_HH
#define PLT_GLOBAL_HH
#import <Cocoa/Cocoa.h>

@interface PLTGlobal : NSObject
+ (bool)gAppRunning;
+ (void)setGAppRunning:(bool)val;
@end
#endif