
#import "HQSpringTransformAnimation.h"
#import "HQAnimationConstant.h"
#import "HQTimingFunctionMath.h"
#import <UIKit/UIKit.h>

@implementation HQSpringTransformAnimation


+(instancetype)springTransformFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue {
    return [self springTransformAnimationWithKeyPath:HQAnimationKeyTransformTranslation duration:1 damping:1 velocity:1 fromValue:fromValue toValue:toValue];
}

+(instancetype)springTransformAnimationWithKeyPath:(NSString *)keyPath
                                          duration:(CFTimeInterval)duration
                                           damping:(double)damping
                                          velocity:(double)velocity
                                         fromValue:(NSValue *)fromValue
                                           toValue:(NSValue *)toValue
{
    HQSpringTransformAnimation *animation = [self.class animationWithKeyPath:@"position"];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 03;
    animation.values = [self animationValuesFromValue:fromValue
                                              toValue:toValue
                                          withDamping:damping
                                          andVelocity:velocity];
    return animation;
}

+(NSArray *)animationValuesFromValue:(NSValue *)fromValue
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
        CGPoint middleValue;
        if (i < 50) {
            middleValue.x = fromPoint.x + i*(distanceBetweenValuesX * 1.2)/50;
            middleValue.y = fromPoint.y + i*(distanceBetweenValuesY * 1.2)/50;
        }else {
            middleValue.x = toPoint.x + [HQTimingFunctionMath dampValueWithBasicValue:fromPoint.x + 0.2 * distanceBetweenValuesX * (kNumberOfPoints - 50)/100 damping:1 velocity:3];
            middleValue.y = toPoint.y + [HQTimingFunctionMath dampValueWithBasicValue:fromPoint.y +  0.2 * distanceBetweenValuesY * (kNumberOfPoints - 50)/100 damping:1 velocity:3];
        }
            [values addObject:[NSValue valueWithCGPoint:middleValue]];
    }
    
    return [NSArray arrayWithArray:values];
}

@end
