//
//  HQBasicAnimation.m
//  HQAnimations
//
//  Created by qianhongqiang on 2017/5/12.
//  Copyright © 2017年 QianHongQiang. All rights reserved.
//

#import "HQBasicAnimation.h"

@implementation HQBasicAnimation

-(void)setDuration:(CFTimeInterval)duration
{
    self.animationState.duration = duration;
}

-(CFTimeInterval)duration
{
    return self.animationState.duration;
}


@end
