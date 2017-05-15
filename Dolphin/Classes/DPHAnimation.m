//
//  DPHAnimation.m
//  Pods
//
//  Created by qianhongqiang on 2017/5/15.
//
//

#import "DPHAnimation.h"
#import "DPHAnimationEngine.h"

@implementation DPHAnimation

-(DPHAnimationState *)animationState
{
    if (!_animationState) {
        _animationState = [[DPHAnimationState alloc] init];
    }
    return _animationState;
}

@end

@implementation NSObject (Dolphin)

- (void)dph_addAnimation:(DPHAnimation *)anim forKey:(NSString *)key
{
    [[DPHAnimationEngine sharedAnimator] addAnimation:anim forObject:self key:key];
}

@end
