#import "PLTApplication.hh"

@implementation PLTApplication
- (bool)loadPoints:(NSString*)filename
{
	if (self.loadedPoints) {
		free(self.loadedPoints);
	}

    size_t numOfPoints = 100;
    Point2D* points    = (Point2D*)malloc(sizeof(Point2D) * numOfPoints);
    for (size_t i = 0; i < numOfPoints; i++)
    {
        points[i].x = (CGFloat)(2 * i);
        points[i].y = (CGFloat)arc4random_uniform(100);
    }
    self.numOfLoadedPoints = numOfPoints;
    self.loadedPoints      = points;
	return true;
}
@end