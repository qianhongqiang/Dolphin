//  HQSpringAnimation.h
//  HQAnimations
//
//  Created by qianhongqiang on 15/9/13.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HQSpringAnimation;
@protocol HQAnimationDelegate;

@interface HQSpringAnimator : NSObject

+ (id)sharedAnimator;

- (void)addAnimation:(HQSpringAnimation *)anim forObject:(id)obj key:(NSString *)key;

@property (weak, nonatomic) id<HQAnimationDelegate> delegate;

@end

@protocol HQAnimationDelegate <NSObject>

- (void)animatorWillAnimate:(HQSpringAnimation *)animator;

- (void)animatorDidAnimate:(HQSpringAnimation *)animator;

@end
