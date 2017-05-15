//
//  DPHBasicAnimation.m
//  Pods
//
//  Created by qianhongqiang on 2017/5/15.
//
//

#import "DPHBasicAnimation.h"

@implementation DPHBasicAnimation

-(void)setDuration:(CFTimeInterval)duration
{
    self.animationState.duration = duration;
}

-(CFTimeInterval)duration
{
    return self.animationState.duration;
}

@end
