#ifndef PLT_POP_UP_BUTTON_HH
#define PLT_POP_UP_BUTTON_HH
#import "PLTApplication.hh"
#include "definitions.h"
#import <Cocoa/Cocoa.h>

@interface PLTPopUpButton : NSPopUpButton
- (void)updateItems:(NSArray*)filterList;
- (void)selecteItemDidChange:(id)sender;
@end

#endif
