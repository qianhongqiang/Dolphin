
#import "HQSpringAnimator.h"
#import "HQSpringAnimation.h"
#import <UIKit/UIKit.h>

#define AnimationKey(anim) [NSString stringWithFormat:@"%lu",(unsigned long)anim.values.hash]

@interface HQSpringAnimator ()

@property (nonatomic, copy) NSMutableDictionary *animationList;

@end

@implementation HQSpringAnimator

+ (id)sharedAnimator
{
    static HQSpringAnimator* _animator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _animator = [[HQSpringAnimator alloc] init];
    });
    return _animator;
}

- (void)addAnimation:(HQSpringAnimation *)anim forObject:(id)obj key:(NSString *)key {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:anim.keyPath];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = anim.duration;
    animation.values = anim.values;
    animation.delegate = self;
    
    UIView *receiver = (UIView *)obj;
    [receiver.layer addAnimation:animation forKey:key];
    
    [self.animationList setObject:@[anim,receiver] forKey:AnimationKey(anim)];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAKeyframeAnimation *animation = (CAKeyframeAnimation *)anim;
    
    if (YES == flag) {
        HQSpringAnimation *animations = [[self.animationList objectForKey:AnimationKey(animation)] firstObject];
        UIView *receiver = [[self.animationList objectForKey:AnimationKey(animation)] lastObject];
        [receiver setCenter:[animations.toValue CGPointValue]];
        [self.animationList removeObjectForKey:AnimationKey(animation)];
    }
}

#pragma mark - getter
-(NSMutableDictionary *)animationList {
    if (nil == _animationList) {
        _animationList = [NSMutableDictionary dictionary];
    }
    return _animationList;
}
@end
