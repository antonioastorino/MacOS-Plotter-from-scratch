#ifndef PLT_WINDOW_HH
#define PLT_WINDOW_HH

#import <Cocoa/Cocoa.h>

@interface PLTWindow : NSWindow
- (void)keyDown:(NSEvent*)event;
@end

#endif