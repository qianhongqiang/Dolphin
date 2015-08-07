//
//  HQAnimationClock.h
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/6.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface HQAnimationClock : CAKeyframeAnimation

//value must between [0,1]
+(instancetype)clock2value:(CGFloat)value;

//fromValue,endValue must between [0,1]
+(instancetype)clockAnimationWithFromValue:(CGFloat)fromValue endValue:(CGFloat)endValue damping:(double)dampig;

@end
