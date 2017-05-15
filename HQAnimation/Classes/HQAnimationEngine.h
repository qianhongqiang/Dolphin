//
//  HQAnimationEngine.h
//  Pods
//
//  Created by qianhongqiang on 2017/5/15.
//
//

#import <Foundation/Foundation.h>

@class HQAnimation;

@interface HQAnimationEngine : NSObject

+ (id)sharedAnimator;

- (void)addAnimation:(HQAnimation *)anim forObject:(id)obj key:(NSString *)key;

@end
