//
//  HQSpringAnimation.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/8.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQSpringAnimation.h"
#import "HQSpringTransformAnimation.h"
#import "HQSpringAnimator.h"
#import "HQTimingFunctionMath.h"

@implementation HQSpringAnimation

+ (instancetype)animationWithPropertyNamed:(NSString *)name {
    HQSpringAnimation *animation = [[self alloc] init];
    animation.keyPath = name;
    return animation;
}

-(NSArray *)animationValuesFromValue:(NSValue *)fromValue
                             toValue:(NSValue *)toValue
                         withDamping:(double)damping
                         andVelocity:(double)velocity
{
    NSMutableArray *values = [NSMutableArray new];
    
    CGPoint fromPoint = [fromValue CGPointValue];
    CGPoint toPoint = [toValue CGPointValue];
    CGFloat distanceBetweenValuesX = toPoint.x - fromPoint.x;
    CGFloat distanceBetweenValuesY = toPoint.y - fromPoint.y;
    
    u_int kNumberOfPoints = 100;
    
    for (int i = 0; i < kNumberOfPoints; ++i) {
        CGPoint middleValuePoint;
        double middleValueRate = (double) i / kNumberOfPoints;
        double middleValue = [HQTimingFunctionMath easeInSpringWithBasicValue:middleValueRate easeInRate:self.acceleration damping:self.damping];
        middleValuePoint.x = fromPoint.x + middleValue * distanceBetweenValuesX;
        middleValuePoint.y = fromPoint.y + middleValue * distanceBetweenValuesY;
        [values addObject:[NSValue valueWithCGPoint:middleValuePoint]];
    }
    
    return [NSArray arrayWithArray:values];
}

-(NSArray *)values {
    return [self animationValuesFromValue:self.fromValue toValue:self.toValue withDamping:self.damping andVelocity:self.springVelocity];
}

@end

@implementation NSObject (HQSpring)

- (void)hq_addAnimation:(HQSpringAnimation *)anim forKey:(NSString *)key {
    [[HQSpringAnimator sharedAnimator] addAnimation:anim forObject:self key:key];
}

- (void)hq_removeAllAnimations {
    
}

- (void)hq_removeAnimationForKey:(NSString *)key {
    
}

- (NSArray *)hq_animationKeys {
    return nil;
}

- (id)hq_animationForKey:(NSString *)key {
    return nil;
}

@end

@implementation CAKeyframeAnimation (HQSpringIdentifier)

-(NSString *)identifier {
    return [NSString stringWithFormat:@"%lu",(unsigned long)self.hash];
}

@end
