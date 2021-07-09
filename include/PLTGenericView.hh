#ifndef PLT_GENERIC_VIEW_HH
#define PLT_GENERIC_VIEW_HH

#import <Cocoa/Cocoa.h>

@interface PLTGenericView : NSView
- (id)initWithFrame:(NSRect)frame;
- (id)init;
- (void)printSomething;
@end

#endif