#ifndef PLT_DATA_TYPES_HH
#define PLT_DATA_TYPES_HH
#include "c/definitions.h"
#import <Cocoa/Cocoa.h>

typedef struct PLTSizedFloatArray
{
    CGFloat* data;
    size_t numOfElements;
} PLTSizedFloatArray;
#endif