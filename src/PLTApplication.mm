#import "PLTApplication.hh"
#include "c/logger.h"

@implementation PLTApplication
- (bool)loadPoints:(NSString*)filename
{
    if (self.rawDataArray)
    {
        free(self.rawDataArray);
    }

    NSString* path    = [[NSBundle mainBundle] pathForResource:filename ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    NSArray* lines =
        [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    size_t numOfElements = [lines count];
    self.rawDataArray    = (CGFloat*)malloc(sizeof(CGFloat) * numOfElements);
    for (NSUInteger i = 0; i < numOfElements; i++)
    {
        self.rawDataArray[i] = [((NSString*)[lines objectAtIndex:i]) floatValue];
    }

    self.numOfLoadedElements = numOfElements;
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