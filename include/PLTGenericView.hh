#ifndef PLT_GENERIC_VIEW_HH
#define PLT_GENERIC_VIEW_HH

#import <Cocoa/Cocoa.h>

@interface PLTGenericView : NSView
@property CGFloat someColor;
- (id)initWithFrame:(NSRect)frame;
- (id)init;
- (void)drawRect:(NSRect)rect;
@end

#endif