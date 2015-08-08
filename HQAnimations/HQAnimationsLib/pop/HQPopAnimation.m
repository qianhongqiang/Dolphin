//
//  HQPopAnimation.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/5.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQPopAnimation.h"
#import "HQTimingFunctionMath.h"

typedef struct {
    char *keyPath;
    double duration;
    double fromValue;
    double toValue;
    double damping;
    double velocity;
} PopAnimationParams;

//数值常量
PopAnimationParams const popParams = (PopAnimationParams){
    .keyPath = "transform.scale",
    .duration = 0.8,
    .fromValue = 0.0,
    .toValue = M_PI,
    .damping = 0.3,
    .velocity = 1.2,
};

static const u_long kPopNumberOfPoints = 100;
static const double kPopVelocityMutiplier = 10;

@implementation HQPopAnimation

+(instancetype)pop
{
    return [self.class animationWithClangKeyPath:popParams.keyPath
                                        duration:popParams.duration
                                         damping:popParams.damping
                                        velocity:popParams.velocity
                                       fromValue:popParams.fromValue
                                         toValue:popParams.toValue];
}

+(instancetype)popAnimationWithKeyPath:(NSString *)keyPath
                              duration:(CFTimeInterval)duration
                               damping:(double)damping
                              velocity:(double)velocity
                             fromValue:(double)fromValue
                               toValue:(double)toValue
{
    HQPopAnimation *animation = [self.class animationWithKeyPath:keyPath];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.values = [self animationValuesFromValue:fromValue
                                              toValue:toValue
                                          withDamping:damping
                                          andVelocity:velocity];
    return animation;
}

+(instancetype)animationWithClangKeyPath:(char *)keyPath
                                duration:(CFTimeInterval)duration
                                 damping:(double)damping
                                velocity:(double)velocity
                               fromValue:(double)fromValue
                                 toValue:(double)toValue
{
    return [self.class popAnimationWithKeyPath:[NSString stringWithUTF8String:keyPath] duration:duration damping:damping velocity:velocity fromValue:fromValue toValue:toValue];
}

#pragma mark - 计算关键帧值相关
+(NSArray *)animationValuesFromValue:(double)fromValue
                             toValue:(double)toValue
                         withDamping:(double)damping
                         andVelocity:(double)velocity
{
    NSMutableArray *values = [NSMutableArray new];
    velocity *= kPopVelocityMutiplier;
    
    for (double i = 1; i < kPopNumberOfPoints + 1; ++i) {
        double x = i / kPopNumberOfPoints;
        double value = [HQTimingFunctionMath popValueWithBasicValue:x velocity:1];
        [values addObject:@(value)];
    }
    
    return [NSArray arrayWithArray:values];
}

@end
