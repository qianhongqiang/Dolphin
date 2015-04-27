//
//  HQEllipticMotionAnimation.h
//  HQAnimations
//
//  Created by qianhongqiang on 15/4/27.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

/*HQEllipticMotionAnimation用来生成带有椭圆动画*/

#import <QuartzCore/QuartzCore.h>

@interface HQEllipticMotionAnimation : CAKeyframeAnimation

+(instancetype)animationWithDuration:(CFTimeInterval)duration
                            longAxis:(double)longAxis
                           shortAxis:(double)shortAxis
                          layerFrame:(CGRect)layerFrame;

@end
