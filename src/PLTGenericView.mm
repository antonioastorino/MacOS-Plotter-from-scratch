#import "PLTGenericView.hh"

@implementation PLTGenericView
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.wantsLayer = TRUE;
        self.someColor  = 0;
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
    CGContextMoveToPoint(ctx, 16.72, 7.22);
    CGContextAddLineToPoint(ctx, 3.29, 20.83);
    CGContextAddLineToPoint(ctx, 0.4, 18.05);
    CGContextAddLineToPoint(ctx, 18.8, -0.47);
    CGContextAddLineToPoint(ctx, 37.21, 18.05);
    CGContextAddLineToPoint(ctx, 34.31, 20.83);
    CGContextAddLineToPoint(ctx, 20.88, 7.22);
    CGContextAddLineToPoint(ctx, 20.88, 42.18);
    CGContextAddLineToPoint(ctx, 16.72, 42.18);
    CGContextAddLineToPoint(ctx, 16.72, 7.22);
    CGContextClosePath(ctx);
    CGContextSetLineWidth(ctx, 1);
    const CGFloat colorArray[4] = {0, self.someColor, self.someColor, 1};
    CGColorSpaceRef colorspace  = CGColorSpaceCreateDeviceRGB();
    CGColorRef aColor           = CGColorCreate(colorspace, colorArray);
    CGContextSetStrokeColorWithColor(ctx, aColor);
    CGContextStrokePath(ctx);
}
@end