//
//  HQPopAnimation.h
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/5.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface HQPopAnimation : CAKeyframeAnimation

//返回参数已经配置好的弹动
+(instancetype)pop;

+(instancetype)popAnimationWithKeyPath:(NSString *)keyPath
                           duration:(CFTimeInterval)duration
                            damping:(double)damping
                           velocity:(double)velocity
                          fromValue:(double)fromValue
                            toValue:(double)toValue;

@end
