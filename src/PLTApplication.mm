#import "PLTApplication.hh"
#include "c/logger.h"

@implementation PLTApplication
- (id)init
{
    self = [super init];
    if (self)
    {
        self.mainPlot = (PLTSizedFloatArray*)malloc(sizeof(PLTSizedFloatArray));
    }
    return self;
}
- (bool)loadPoints:(NSString*)filename
{
    if (self.mainPlot)
    {
        free(self.mainPlot->data);
        self.mainPlot->data = nil;
    }
    NSString* path    = [[NSBundle mainBundle] pathForResource:filename ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    NSArray* lines =
        [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    size_t numOfElements = [lines count];
    self.mainPlot->data   = (CGFloat*)malloc(sizeof(CGFloat) * numOfElements);
    for (NSUInteger i = 0; i < numOfElements; i++)
    {
        self.mainPlot->data[i] = [((NSString*)[lines objectAtIndex:i]) floatValue];
    }

    self.mainPlot->numOfElements = numOfElements;
    return true;
}

- (bool)loadFilters:(NSString*)filename
{

    NSString* path    = [[NSBundle mainBundle] pathForResource:filename ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    LOG_DEBUG("File to read: %s", path.UTF8String);
    self.filterArray =
        [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return true;
}
@end