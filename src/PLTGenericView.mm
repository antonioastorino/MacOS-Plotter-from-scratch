#import "PLTGenericView.hh"

@implementation PLTGenericView
{
    size_t numOfPoints;
    Point2D* points;
    PLTApplication* applicationObj;
}
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.wantsLayer      = TRUE;
        self.someColor       = 0;
        self->numOfPoints    = 0;
        self->points         = nil;
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

- (void)setPoints:(PLTApplication*)appObj
{
    self->applicationObj = appObj;
    self->points         = appObj.loadedPoints;
    self->numOfPoints    = appObj.numOfLoadedPoints;
}

- (void)drawRect:(NSRect)rect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] CGContext];

    CGContextBeginPath(ctx);
    size_t pointIndex = 0;
    if (self->numOfPoints)
    {
        Point2D* p = self->points;
        CGContextMoveToPoint(ctx, p[0].x, p[0].y);

        for (size_t i = 1; i < self->numOfPoints; i++)
        {
            CGContextAddLineToPoint(ctx, p[i].x, p[i].y);
        }
    }
    CGContextSetLineWidth(ctx, 1);
    const CGFloat colorArray[4] = {0, self.someColor, self.someColor, 1};
    CGColorSpaceRef colorspace  = CGColorSpaceCreateDeviceRGB();
    CGColorRef aColor           = CGColorCreate(colorspace, colorArray);
    CGContextSetStrokeColorWithColor(ctx, aColor);
    CGContextStrokePath(ctx);
}
@end