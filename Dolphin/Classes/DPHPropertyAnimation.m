//
//  DPHPropertyAnimation.m
//  Pods
//
//  Created by qianhongqiang on 2017/5/15.
//
//

#import "DPHPropertyAnimation.h"

@implementation DPHPropertyAnimation

-(void)setFromValue:(id)fromValue
{
    self.animationState.fromValue = fromValue;
}

-(void)setToValue:(id)toValue
{
    self.animationState.toValue = toValue;
}

@end
