//
//  HQPropertyAnimation.m
//  HQAnimations
//
//  Created by qianhongqiang on 2017/5/12.
//  Copyright © 2017年 QianHongQiang. All rights reserved.
//

#import "HQPropertyAnimation.h"

@implementation HQPropertyAnimation

-(void)setFromValue:(id)fromValue
{
    self.animationState.fromValue = fromValue;
}

-(void)setToValue:(id)toValue
{
    self.animationState.toValue = toValue;
}

@end
