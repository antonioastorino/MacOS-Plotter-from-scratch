#ifndef PLT_POP_UP_BUTTON_HH
#define PLT_POP_UP_BUTTON_HH
#import "PLTApplication.hh"
#include "c/definitions.h"
#import <Cocoa/Cocoa.h>

@interface PLTPopUpButton : NSPopUpButton
- (void)initialize:(PLTApplication*)appObj;
- (void)updateItems;
- (void)selecteItemDidChange:(id)sender;
@end

#endif
