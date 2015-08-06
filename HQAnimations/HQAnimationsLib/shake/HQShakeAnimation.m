//
//  HQShakeAnimation.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/6.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQShakeAnimation.h"
#import "HQTimingFunctionMath.h"

typedef struct {
    char *keyPath;
    double duration;
    double fromValue;
    double toValue;
    double tension;
    double velocity;
} ShakeAnimationParams;

//数值常量
ShakeAnimationParams const shakeParams = (ShakeAnimationParams){
    .keyPath = "transform.translation.x",
    .duration = 0.8,
    .fromValue = 0.0,
    .toValue = M_PI,
    .tension = 5,
    .velocity = 0.4,
};

static const u_long kPopNumberOfPoints = 100;
static const double kPopVelocityMutiplier = 10;

@implementation HQShakeAnimation

+(instancetype)shake
{
    return [self.class animationWithClangKeyPath:shakeParams.keyPath
                                        duration:shakeParams.duration
                                         tension:shakeParams.tension
                                        velocity:shakeParams.velocity
                                       fromValue:shakeParams.fromValue
                                         toValue:shakeParams.toValue];
}

+(instancetype)shakeAnimationWithKeyPath:(NSString *)keyPath
                              duration:(CFTimeInterval)duration
                               tension:(double)tension
                              velocity:(double)velocity
                             fromValue:(double)fromValue
                               toValue:(double)toValue
{
    HQShakeAnimation *animation = [self.class animationWithKeyPath:keyPath];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.values = [self animationValuesFromValue:fromValue
                                              toValue:toValue
                                          withTension:tension
                                          andVelocity:velocity];
    return animation;
}

+(instancetype)animationWithClangKeyPath:(char *)keyPath
                                duration:(CFTimeInterval)duration
                                 tension:(double)tension
                                velocity:(double)velocity
                               fromValue:(double)fromValue
                                 toValue:(double)toValue
{
    return [self.class shakeAnimationWithKeyPath:[NSString stringWithUTF8String:keyPath] duration:duration tension:tension velocity:velocity fromValue:fromValue toValue:toValue];
}

#pragma mark - 计算关键帧值相关
+(NSArray *)animationValuesFromValue:(double)fromValue
                             toValue:(double)toValue
                         withTension:(double)tension
                         andVelocity:(double)velocity
{
    NSMutableArray *values = [NSMutableArray new];
    velocity *= kPopVelocityMutiplier;
    
    for (double i = 1; i < kPopNumberOfPoints + 1; ++i) {
        double x = i / kPopNumberOfPoints;
        double value = [HQTimingFunctionMath shakeValueWithBasicValue:x tension:tension velocity:velocity];
        NSLog(@"%f",value);
        [values addObject:@(value)];
    }
    
    return [NSArray arrayWithArray:values];
}

@end
