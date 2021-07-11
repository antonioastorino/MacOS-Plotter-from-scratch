#ifndef PLT_GENERIC_VIEW_HH
#define PLT_GENERIC_VIEW_HH

#import <Cocoa/Cocoa.h>
#import "PLTDataTypes.hh"
#import "PLTApplication.hh"

@interface PLTGenericView : NSView
@property CGFloat someColor;

- (id)initWithFrame:(NSRect)frame;
- (id)init;
- (void)drawRect:(NSRect)rect;
- (void)setPoints:(PLTApplication*)appObj;
@end

#endif