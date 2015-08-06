//
//  HQTimingFunctionMath.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/5.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQTimingFunctionMath.h"

static inline double dampTimingFunction(double value,double damping,double velocity) {
    return pow(M_E, -damping * value) * cos(velocity * value);
}

static inline double popTimingFunction(double value, double velocity) {
    double param = value > 0.5 ? value : (1 - value);
    return cos(value * M_PI * 2 * velocity) * param;
}

static inline double shakeTimingFunction(double value, double tension, double velocity) {
    return cos(value * M_PI * 2 * velocity) * (1-value) * tension;
}

static inline double b3_friction3(double x)
{
    return (0.00000045 * pow(x, 3)) - (0.000332 * pow(x, 2)) + 0.1078 * x + 5.84;
}

@implementation HQTimingFunctionMath

+(double)dampValueWithBasicValue:(double)value damping:(double)damping velocity:(double)velocity {
    return dampTimingFunction(value, damping, velocity);
}

+(double)popValueWithBasicValue:(double)value velocity:(double)velocity {
    return popTimingFunction(value,velocity);
}

+(double)shakeValueWithBasicValue:(double)value tension:(double)tension velocity:(double)velocity {
    return shakeTimingFunction(value,tension,velocity);
}

@end
