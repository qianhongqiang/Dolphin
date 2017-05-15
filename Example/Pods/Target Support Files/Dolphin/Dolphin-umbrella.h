#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Dolphin.h"
#import "DPHAnimation.h"
#import "DPHAnimationEngine.h"
#import "DPHAnimationState.h"
#import "DPHBasicAnimation.h"
#import "DPHPropertyAnimation.h"

FOUNDATION_EXPORT double DolphinVersionNumber;
FOUNDATION_EXPORT const unsigned char DolphinVersionString[];

