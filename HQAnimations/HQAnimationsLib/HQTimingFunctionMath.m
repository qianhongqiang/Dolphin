//
//  HQTimingFunctionMath.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/5.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQTimingFunctionMath.h"

static double const totalValueToOne = 1;

static double mappingValue = 0.5;

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
    
    if (mappedValue <= totalValueToOne && value >= 0) {
        return pow(mappedValue, easeInRate);
    }else if (mappedValue < (totalValueToOne / mappingValue)) {
        double lastSpringValue = mappedValue - totalValueToOne;
        double velocity =  M_PI / ((totalValueToOne / mappedValue) - totalValueToOne);
        
        return totalValueToOne + (1 / damping) * easeInRate * pow(M_E, -damping * lastSpringValue) * sin(lastSpringValue * velocity);
    }else {
        [NSException raise:@"timingFunctionException" format:@"value must between 0 and 1"];
        return 0;
    }
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

+(double)springValueEithBasicValue:(double)value tension:(double)tension velocity:(double)velocity {
    return springTimingFunction(value,tension,velocity);
}

+(double)easeInSpringWithBasicValue:(double)value easeInRate:(double)rate damping:(double)damping {
    return easeInSpringTimingFunction(value, rate, damping);
}

@end
