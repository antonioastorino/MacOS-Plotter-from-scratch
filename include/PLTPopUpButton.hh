#ifndef PLT_POP_UP_BUTTON_HH
#define PLT_POP_UP_BUTTON_HH
#import "PLTApplication.hh"
#import <Cocoa/Cocoa.h>

@interface PLTPopUpButton : NSPopUpButton
- (void)initialize:(PLTApplication*)appObj;
- (void)updateItems;
- (void)test_action:(id)sender;
@end

#endif
