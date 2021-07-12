#import "PLTPopUpButton.hh"
#import "PLTApplication.hh"
#include "c/logger.h"

@implementation PLTPopUpButton
{
    PLTApplication* applicationObj;
}
- (void)initialize:(PLTApplication*)appObj
{
    if (self->applicationObj)
    {
        LOG_WARN("Pop up button already initialized");
        return;
    }
    self->applicationObj = appObj;
    [self updateItems];
}

- (void)updateItems
{
    NSArray* filterList = self->applicationObj.filterArray;
    for (size_t i = 0; i < filterList.count; i++)
    {
        [self addItemWithTitle:[filterList objectAtIndex:i]];
    }

    [self setAction:@selector(test_action:)];
    [self setTarget:self];
}

- (void)test_action:(id)sender
{
    LOG_DEBUG("Changed selection %s", self.selectedItem.title.UTF8String);
    [self setTitle:self.selectedItem.title];
    NSEvent* event = [NSEvent otherEventWithType:NSApplicationDefined
                                        location:NSMakePoint(0, 0)
                                   modifierFlags:0
                                       timestamp:0
                                    windowNumber:0
                                         context:nil
                                         subtype:0
                                           data1:0
                                           data2:0];
    [[NSApplication sharedApplication] postEvent:event atStart:YES];
}
@end