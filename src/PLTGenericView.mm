#import "PLTGenericView.hh"

@implementation PLTGenericView
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.wantsLayer = TRUE;
        self.someColor  = 0;
        self.numOfPoints = 0;
        self.points = nil;
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

- (void)drawRect:(NSRect)rect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] CGContext];

    CGContextBeginPath(ctx);
    size_t pointIndex = 0;
    if (self.numOfPoints)
    {
        Point2D* points = self.points;
        CGContextMoveToPoint(ctx, points[0].x, points[0].y);

        for (size_t i = 1; i < self.numOfPoints; i++)
        {
            CGContextAddLineToPoint(ctx, points[i].x, points[i].y);
        }
    }
    CGContextSetLineWidth(ctx, 1);
    const CGFloat colorArray[4] = {0, self.someColor, self.someColor, 1};
    CGColorSpaceRef colorspace  = CGColorSpaceCreateDeviceRGB();
    CGColorRef aColor           = CGColorCreate(colorspace, colorArray);
    CGContextSetStrokeColorWithColor(ctx, aColor);
    CGContextStrokePath(ctx);
    self.numOfPoints = 0;
    self.points = nil;
}
@end