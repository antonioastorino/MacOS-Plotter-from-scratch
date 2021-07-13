#ifndef PLT_GENERIC_VIEW_HH
#define PLT_GENERIC_VIEW_HH

#import "PLTApplication.hh"
#import "PLTDataTypes.hh"
#include "c/definitions.h"
#import <Cocoa/Cocoa.h>

@interface PLTGenericView : NSView
- (void)addOffset:(CGFloat)offset;
- (void)setPoints:(PLTApplication*)appObj;
@end

#endif