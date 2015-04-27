//
//  HQEllipticAnimationButton.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/4/27.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQEllipticAnimationButton.h"
#import "HQEllipticMotionAnimation.h"

@implementation HQEllipticAnimationButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSublayers];
    }
    return self;
}

-(void)setupSublayers
{
    //下层
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = self.bounds;
    bottomLayer.contents = (__bridge id)([ UIImage imageNamed:@"testImage"].CGImage);
    [self.layer addSublayer:bottomLayer];
    
    HQEllipticMotionAnimation *topAnimation = [HQEllipticMotionAnimation animationWithDuration:3 longAxis:3 shortAxis:2 layerFrame:self.frame];
    
    [bottomLayer addAnimation:topAnimation forKey:nil];
    //下层
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = self.bounds;
    topLayer.contents = (__bridge id)([ UIImage imageNamed:@"topLayer"].CGImage);
    [self.layer addSublayer:topLayer];
    
    HQEllipticMotionAnimation *bottomAnimation = [HQEllipticMotionAnimation animationWithDuration:3.5 longAxis:3.5 shortAxis:2.5 layerFrame:self.frame];
    
    [topLayer addAnimation:bottomAnimation forKey:nil];
}

@end
