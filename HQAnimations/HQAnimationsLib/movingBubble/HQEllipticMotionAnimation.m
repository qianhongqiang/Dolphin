//
//  HQEllipticMotionAnimation.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/4/27.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQEllipticMotionAnimation.h"

@implementation HQEllipticMotionAnimation

+(instancetype)animationWithDuration:(CFTimeInterval)duration
                            longAxis:(double)longAxis
                           shortAxis:(double)shortAxis
                          layerFrame:(CGRect)layerFrame
{
    HQEllipticMotionAnimation *ellipticAnmation = [self.class animationWithKeyPath:@"position"];
    
    ellipticAnmation.removedOnCompletion = NO;
    ellipticAnmation.fillMode = kCAFillModeBackwards;
    ellipticAnmation.duration = duration;
    ellipticAnmation.calculationMode = kCAAnimationPaced;
    ellipticAnmation.repeatCount = MAXFLOAT;
    
    CGMutablePathRef ellipticPath = CGPathCreateMutable();
    
    CGPathAddEllipseInRect(ellipticPath, NULL, CGRectMake(layerFrame.size.width/2-longAxis/2, layerFrame.size.height/2-shortAxis/2, longAxis, shortAxis));
    ellipticAnmation.path = ellipticPath;
    CGPathRelease(ellipticPath);
    ellipticAnmation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    return ellipticAnmation;
}

@end
