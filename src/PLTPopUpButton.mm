#import "PLTPopUpButton.hh"
#import "PLTApplication.hh"
#include "c/logger.h"

@implementation PLTPopUpButton

- (void)updateItems:(NSArray*)filterList
{
    for (size_t i = 0; i < filterList.count; i++)
    {
        [self addItemWithTitle:[filterList objectAtIndex:i]];
    }

    [self setAction:@selector(selecteItemDidChange:)];
    [self setTarget:self];
}

- (void)selecteItemDidChange:(id)sender
{
    LOG_DEBUG("Changed selection %s", self.selectedItem.title.UTF8String);
    [self setTitle:self.selectedItem.title];
    NSEvent* event = [NSEvent otherEventWithType:NSEventTypeApplicationDefined
                                        location:NSMakePoint(0, 0)
                                   modifierFlags:0
                                       timestamp:0
                                    windowNumber:0
                                         context:nil
                                         subtype:0
                                           data1:[self indexOfSelectedItem]
                                           data2:0];
    [[NSApplication sharedApplication] postEvent:event atStart:YES];
}
@end