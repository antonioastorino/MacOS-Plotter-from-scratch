#import "PLTGenericView.hh"
#include "c/datahandler.h"
#include "c/logger.h"

@implementation PLTGenericView
{
    PLTApplication* applicationObj;
}
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.wantsLayer      = TRUE;
        self->applicationObj = nil;
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        self.wantsLayer = TRUE;
    }
    return self;
}

- (void)addOffset:(CGFloat)offset
{
    CGFloat height = self.frame.size.height;
    CGFloat width  = self.frame.size.width;
    if ((offset >= height) || (offset >= width))
    {
        LOG_WARN("Offset %lf too large and not applicable.", offset);
    }
    else
    {
        [self setFrameSize:NSMakeSize(width - 2 * offset, height - 2 * offset)];
        [self
            setFrameOrigin:NSMakePoint(self.frame.origin.x + offset, self.frame.origin.y + offset)];
    }
}

- (void)setPoints:(PLTApplication*)appObj
{
    self->applicationObj = appObj;
}

- (void)drawRect:(NSRect)rect
{
    CGFloat* rawDataArray = self->applicationObj.rawDataArray;
    size_t numOfElements  = self->applicationObj.numOfLoadedElements;
    CGContextRef ctx      = [[NSGraphicsContext currentContext] CGContext];

    CGContextBeginPath(ctx);
    CGFloat x = 0, y = 0;

    if (numOfElements)

    {
        double normalizedData[numOfElements];

        fit_in_range(rawDataArray, numOfElements, 0.0f, self.frame.size.height, normalizedData);
        CGContextMoveToPoint(ctx, 0, normalizedData[0]);

        CGFloat x_step = self.frame.size.width / numOfElements;

        for (size_t i = 1; i < numOfElements; i++)
        {
            CGContextAddLineToPoint(ctx, x_step * i, normalizedData[i]);
        }
    }
    CGContextSetLineWidth(ctx, 1);
    const CGFloat colorArray[4] = {0.2, 1, 0.2, 1};
    CGColorSpaceRef colorspace  = CGColorSpaceCreateDeviceRGB();
    CGColorRef aColor           = CGColorCreate(colorspace, colorArray);
    CGContextSetStrokeColorWithColor(ctx, aColor);
    CGContextStrokePath(ctx);
}
@end