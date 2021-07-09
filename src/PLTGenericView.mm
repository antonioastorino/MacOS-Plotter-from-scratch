#import "../include/PLTGenericView.hh"

@implementation PLTGenericView
-(id) initWithFrame:(NSRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.wantsLayer = TRUE;
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        self.wantsLayer = TRUE;
    }
    return self;
}
- (void)printSomething
{
    printf("Something\n");
}
@end