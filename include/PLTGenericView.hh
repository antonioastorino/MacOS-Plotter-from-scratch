#ifndef PLT_GENERIC_VIEW_HH
#define PLT_GENERIC_VIEW_HH

#import <Cocoa/Cocoa.h>

typedef struct Point2D
{
    CGFloat x;
    CGFloat y;
} Point2D;

@interface PLTGenericView : NSView
@property CGFloat someColor;
@property size_t numOfPoints;
@property Point2D* points;
- (id)initWithFrame:(NSRect)frame;
- (id)init;
- (void)drawRect:(NSRect)rect;
@end

#endif