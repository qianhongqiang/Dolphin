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

#import "HQAnimation.h"
#import "HQAnimationEngine.h"
#import "HQAnimationState.h"
#import "HQBasicAnimation.h"
#import "HQPropertyAnimation.h"

FOUNDATION_EXPORT double DolphinVersionNumber;
FOUNDATION_EXPORT const unsigned char DolphinVersionString[];

