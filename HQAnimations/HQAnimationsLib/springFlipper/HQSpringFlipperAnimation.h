//
//  HQSpringFlipperAnimation.h
//  HQAnimations
//
//  Created by qianhongqiang on 15/4/27.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

/*HQSpringFlipperAnimation用来生成带有简谐振动效果的翻转动画，你可以直接调用springFlipper方法获得一个动画的实例，期中参数都已经由我设置过，也可以通过下面的方法自己设置参数来获取实例*/

#import <QuartzCore/QuartzCore.h>

@interface HQSpringFlipperAnimation : CAKeyframeAnimation

//返回参数已经配置好的弹簧翻转的动画实例
+(instancetype)springFlipper;

+(instancetype)animationWithKeyPath:(NSString *)keyPath
                            duration:(CFTimeInterval)duration
                             damping:(double)damping
                            velocity:(double)velocity
                           fromValue:(double)fromValue
                             toValue:(double)toValue;

@end
