
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
    animation.duration = 0.7;
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
        CGPoint middleValuePoint;
        double test = (double) i / kNumberOfPoints;
        
        double middleValue = [HQTimingFunctionMath easeInSpringWithBasicValue:test easeInRate:1 damping:3];
        middleValuePoint.x = fromPoint.x + middleValue * distanceBetweenValuesX;
        middleValuePoint.y = fromPoint.y + middleValue * distanceBetweenValuesY;
        [values addObject:[NSValue valueWithCGPoint:middleValuePoint]];
    }
    
    return [NSArray arrayWithArray:values];
}

@end
