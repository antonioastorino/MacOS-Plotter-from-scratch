#import "PLTPopUpButton.hh"
#import "PLTApplication.hh"
#include "logger.h"

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
    [self setTitle:self.selectedItem.title];
    LOG_DEBUG("Changed selection %s", self.title.UTF8String);
    NSInteger value;
    if (![[NSScanner scannerWithString:self.title] scanInteger:&value])
    {
        LOG_WARN("The title %s does not contain the saught integer", self.title.UTF8String);
        return;
    }
    NSEvent* event = [NSEvent otherEventWithType:NSEventTypeApplicationDefined
                                        location:NSMakePoint(0, 0)
                                   modifierFlags:0
                                       timestamp:0
                                    windowNumber:0
                                         context:nil
                                         subtype:0
                                           data1:value
                                           data2:0];
    [[NSApplication sharedApplication] postEvent:event atStart:YES];
}
@end