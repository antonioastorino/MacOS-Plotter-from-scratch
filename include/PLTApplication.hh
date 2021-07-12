#ifndef PLT_APPLICATION_HH
#define PLT_APPLICATION_HH

#import "PLTDataTypes.hh"
#import <Cocoa/Cocoa.h>

@interface PLTApplication : NSObject
@property CGFloat* rawDataArray;
@property size_t numOfLoadedElements;
- (bool)loadPoints:(NSString*)filename;
@end
#endif