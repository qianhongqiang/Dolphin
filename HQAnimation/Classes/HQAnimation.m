//
//  HQAnimation.m
//  HQAnimations
//
//  Created by qianhongqiang on 2017/5/11.
//  Copyright © 2017年 QianHongQiang. All rights reserved.
//

#import "HQAnimation.h"
#import "HQAnimator.h"

@implementation HQAnimation

-(HQAnimationState *)animationState
{
    if (!_animationState) {
        _animationState = [[HQAnimationState alloc] init];
    }
    return _animationState;
}

@end

@implementation NSObject (HQAnimation)

- (void)qhq_addAnimation:(HQAnimation *)anim forKey:(NSString *)key
{
    [[HQAnimator sharedAnimator] addAnimation:anim forObject:self key:key];
}

@end
