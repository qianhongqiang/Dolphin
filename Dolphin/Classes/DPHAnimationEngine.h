//
//  DPHAnimationEngine.h
//  Pods
//
//  Created by qianhongqiang on 2017/5/15.
//
//

#import <Foundation/Foundation.h>

@class DPHAnimation;

@interface DPHAnimationEngine : NSObject

+ (id)sharedAnimator;

- (void)addAnimation:(DPHAnimation *)anim forObject:(id)obj key:(NSString *)key;

@end
