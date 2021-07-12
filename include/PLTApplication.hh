#ifndef PLT_APPLICATION_HH
#define PLT_APPLICATION_HH

#import "PLTDataTypes.hh"
#import <Cocoa/Cocoa.h>

@interface PLTApplication : NSObject
@property CGFloat* rawDataArray;
@property size_t numOfLoadedElements;
@property NSArray *filterArray;
- (bool)loadPoints:(NSString*)filename;
- (bool)loadFilters:(NSString*)filename;
@end
#endif