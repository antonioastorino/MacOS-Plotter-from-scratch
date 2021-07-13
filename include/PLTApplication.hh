#ifndef PLT_APPLICATION_HH
#define PLT_APPLICATION_HH

#import "PLTDataTypes.hh"
#import "PLTGlobal.hh"
#include "c/definitions.h"

@interface PLTApplication : NSObject
@property PLTSizedFloatArray* mainPlot;
@property PLTSizedFloatArray* averagePlot;
@property NSArray* filterArray;
- (bool)loadPoints:(NSString*)filename;
- (bool)loadFilters:(NSString*)filename;
- (void)update:(NSEvent*)event;
@end

#if TEST == 1
void test_plt_application();
#endif
#endif