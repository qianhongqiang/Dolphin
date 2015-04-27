//
//  HQSpringFlipperAnimation.h
//  HQAnimations
//
//  Created by qianhongqiang on 15/4/27.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface HQSpringFlipperAnimation : CAKeyframeAnimation

//返回参数已经配置好的弹簧翻转的动画实例
+ (instancetype)springFlipper;

+ (instancetype)animationWithKeyPath:(NSString *)keyPath
                            duration:(CFTimeInterval)duration
                             damping:(double)damping
                            velocity:(double)velocity
                           fromValue:(double)fromValue
                             toValue:(double)toValue;

@end
