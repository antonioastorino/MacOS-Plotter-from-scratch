#ifndef PLT_APPLICATION_HH
#define PLT_APPLICATION_HH

#import <Cocoa/Cocoa.h>
#import "PLTDataTypes.hh"

@interface PLTApplication: NSObject
@property Point2D* loadedPoints;
@property size_t numOfLoadedPoints;
-(bool) loadPoints:(NSString*)filename; 
@end
#endif