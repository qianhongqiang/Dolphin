
#import "HQSpringAnimator.h"
#import "HQSpringAnimation.h"
#import <UIKit/UIKit.h>

@interface HQSpringAnimator ()

@property (nonatomic, copy) NSMutableArray *animationList;

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
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (YES == flag) {
        NSLog(@"%%%%%%%%%%");
    }
}

#pragma mark - getter
-(NSMutableArray *)animationList {
    if (nil == _animationList) {
        _animationList = [NSMutableArray array];
    }
    return _animationList;
}
@end
