#ifndef PLT_GENERIC_VIEW_HH
#define PLT_GENERIC_VIEW_HH

#import "PLTApplication.hh"
#import "PLTDataTypes.hh"
#import <Cocoa/Cocoa.h>

@interface PLTGenericView : NSView
- (id)initWithFrame:(NSRect)frame;
- (id)init;
- (void)addOffset:(CGFloat)offset;
- (void)drawRect:(NSRect)rect;
- (void)setPoints:(PLTApplication*)appObj;
@end

#endif