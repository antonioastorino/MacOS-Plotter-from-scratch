#import "PLTApplication.hh"
#import "PLTAppDelegate.hh"
#import "PLTGenericView.hh"
#import "PLTPopUpButton.hh"
#import "PLTWindow.hh"
#include "c/logger.h"

@implementation PLTApplication
{
    PLTWindow* window;
    PLTAppDelegate* windowDelegate;
    PLTGenericView* mainView;
    PLTGenericView* averageView;
    PLTPopUpButton* popUpButton;
    CGFloat offset;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        self.mainPlot    = (PLTSizedFloatArray*)malloc(sizeof(PLTSizedFloatArray));
        self.averagePlot = (PLTSizedFloatArray*)malloc(sizeof(PLTSizedFloatArray));
        self->offset     = 5.0f;
        [self initLogger];
        [self initWindow];
        [self configureWindow];
    }
    return self;
}

- (void)initLogger
{
    // Getting the user's Lib folder
    NSString* userLibFolder =
        [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)
            objectAtIndex:0];

    const char* userLibFolderStr = userLibFolder.UTF8String;
    const char* appLogPath       = strcat((char*)userLibFolderStr, "/Logs/plotter.log");
    init_logger(appLogPath, appLogPath);
    LOG_INFO("Logger initialized!");
}

- (void)initWindow
{
    // Retrieve the screen coordinates of the main screen
    CGFloat screenWidth  = [NSScreen mainScreen].frame.size.width;
    CGFloat screenHeight = [NSScreen mainScreen].frame.size.height;

    // Set window style parameters
    NSWindowStyleMask windowStyleMask = NSWindowStyleMaskClosable | NSWindowStyleMaskTitled;

    self->window =
        [[PLTWindow alloc] initWithContentRect:NSMakeRect(screenWidth / 4.0f, screenHeight / 4.0f,
                                                          screenWidth / 2.0f, screenHeight / 2.0f)
                                     styleMask:windowStyleMask
                                       backing:NSBackingStoreBuffered
                                         defer:YES];

    self->mainView    = [[PLTGenericView alloc] init];
    self->averageView = [[PLTGenericView alloc] init];
    self->popUpButton = [[PLTPopUpButton alloc] init];
    self->windowDelegate = [[PLTAppDelegate alloc] init];
}
- (void)configureWindow
{
    CGFloat windowHeigth = self->window.contentView.bounds.size.height;
    CGFloat windowWidth  = self->window.contentView.bounds.size.width;
    [self->mainView setFrame:NSMakeRect(0, windowHeigth / 2, windowWidth, windowHeigth / 2)];
    [self->mainView addOffset:self->offset];
    [self->mainView.layer setBackgroundColor:[NSColor blackColor].CGColor];
    [self->averageView addOffset:self->offset];
    [self->averageView.layer setBackgroundColor:[NSColor blackColor].CGColor];
    [self->averageView setFrame:NSMakeRect(0, 0, windowWidth, windowHeigth / 2)];
    [self->popUpButton setFrame:NSMakeRect(0, windowHeigth / 2 - 20 - self->offset, 200, 20)];
    [self->popUpButton setPullsDown:YES];
    [self->window setBackgroundColor:[NSColor systemGrayColor]];
    [self->window makeKeyAndOrderFront:nil];
    [self->window setTitle:@"plotter"];

    if (!([self loadPoints:@"floats"] && [self loadFilters:@"filters"]))
    {
        exit(1);
    }
    [self->mainView setPoints:self.mainPlot];
    [self->averageView setPoints:self.mainPlot];
    [self->window setDelegate:windowDelegate];
    [self->popUpButton updateItems:self.filterArray];
    [[self->window contentView] addSubview:mainView];
    [[self->window contentView] addSubview:averageView];
    [[self->window contentView] addSubview:popUpButton];
}
- (bool)loadPoints:(NSString*)filename
{
    if (self.mainPlot)
    {
        free(self.mainPlot->data);
        free(self.averagePlot->data);
        self.mainPlot->data    = nil;
        self.averagePlot->data = nil;
    }
    NSString* path    = [[NSBundle mainBundle] pathForResource:filename ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    NSArray* lines =
        [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    size_t numOfElements   = [lines count];
    self.mainPlot->data    = (CGFloat*)malloc(sizeof(CGFloat) * numOfElements);
    self.averagePlot->data = (CGFloat*)malloc(sizeof(CGFloat) * numOfElements);
    for (NSUInteger i = 0; i < numOfElements; i++)
    {
        self.mainPlot->data[i]    = [((NSString*)[lines objectAtIndex:i]) floatValue];
        self.averagePlot->data[i] = self.mainPlot->data[i];
    }

    self.mainPlot->numOfElements    = numOfElements;
    self.averagePlot->numOfElements = numOfElements;
    return true;
}

- (bool)loadFilters:(NSString*)filename
{

    NSString* path    = [[NSBundle mainBundle] pathForResource:filename ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    LOG_DEBUG("File to read: %s", path.UTF8String);
    self.filterArray =
        [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return true;
}

- (void)update:(NSEvent*)event
{
    if ([event type] == NSEventTypeApplicationDefined)
    {
        switch ([event subtype])
        {
        case (PLTEventSubtypeFilterChange):
            LOG_DEBUG("Filter changed to %lu", [event data1]);
            break;
        default:
            break;
        }
    }
    [self->mainView setNeedsDisplay:YES];
}
@end