//
//  HQTimingFunctionMath.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/5.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQTimingFunctionMath.h"

@implementation HQTimingFunctionMath

+(double)dampValueWithBasicValue:(double)value damping:(double)damping velocity:(double)velocity
{
    return pow(M_E, -damping * value) * cos(velocity * value);
}

@end
