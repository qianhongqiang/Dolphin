//
//  HQTimingFunctionMath.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/5.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQTimingFunctionMath.h"

static double mappingValue = 0.8;

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

static inline double springTimingFunction(double value, double tension, double velocity) {
    return cos(value * M_PI * 2 * velocity) * (1-value) * tension;
}

static inline double easeInSpringTimingFunction(double value,double easeInRate,double damping){
    
    double mappedValue = value / mappingValue;
    
    if (mappedValue <= 1 && value >= 0) {
        return pow(mappedValue, easeInRate);
    }else if (mappedValue < (1 / mappingValue)) {
        double lastSpringValue = mappedValue - 1;
        double velocity = 2 * M_PI / ((1 / mappedValue) - 1);
        
        return 1 + pow(M_E, -damping * lastSpringValue) * sin(lastSpringValue * velocity);
    }else {
        [NSException raise:@"timingFunctionException" format:@"value must between 0 and 1"];
        return 0;
    }
}

//static inline double b2_friction1(double x)
//{
//    return (0.0007 * pow(x, 3)) - (0.031 * pow(x, 2)) + 0.64 * x + 1.28;
//}
//
//static inline double b3_friction1(double x)
//{
//    return (0.0007 * pow(x, 3)) - (0.031 * pow(x, 2)) + 0.64 * x + 1.28;
//}
//
//static inline double b3_friction2(double x)
//{
//    return (0.000044 * pow(x, 3)) - (0.006 * pow(x, 2)) + 0.36 * x + 2.;
//}
//
//static inline double b3_friction3(double x)
//{
//    return (0.00000045 * pow(x, 3)) - (0.000332 * pow(x, 2)) + 0.1078 * x + 5.84;
//}

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

+(double)springValueEithBasicValue:(double)value tension:(double)tension velocity:(double)velocity {
    return springTimingFunction(value,tension,velocity);
}

+(double)easeInSpringWithBasicValue:(double)value easeInRate:(double)rate damping:(double)damping {
    return easeInSpringTimingFunction(value, rate, damping);
}

@end
