//
//  HQAnimationClock.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/6.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface HQSpringTransformAnimation : CAKeyframeAnimation

+(instancetype)springTransformFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue;

@end
