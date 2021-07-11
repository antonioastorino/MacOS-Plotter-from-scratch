#import "PLTApplication.hh"

@implementation PLTApplication
- (bool)loadPoints:(NSString*)filename
{
    if (self.loadedPoints)
    {
        free(self.loadedPoints);
    }

    NSString* path = [[NSBundle mainBundle] pathForResource:@"floats" ofType:@"txt"];

    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    NSArray* lines =
        [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    size_t numOfPoints = [lines count];
    Point2D* points    = (Point2D*)malloc(sizeof(Point2D) * numOfPoints);
    for (NSUInteger i = 0; i < numOfPoints; i++)
    {
        CGFloat convertedValue = [((NSString*)[lines objectAtIndex:i]) floatValue];
   
        points[i].x = (CGFloat)(i * 2);
        points[i].y = convertedValue / 2.0f;
    }

    self.numOfLoadedPoints = numOfPoints;
    self.loadedPoints      = points;
    return true;
}
@end