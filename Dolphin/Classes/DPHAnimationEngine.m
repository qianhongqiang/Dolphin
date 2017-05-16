//
//  DPHAnimationEngine.m
//  Pods
//
//  Created by qianhongqiang on 2017/5/15.
//
//

#import "DPHAnimationEngine.h"
#import "DPHAnimationState.h"
#import "DPHAnimation.h"
#import <QuartzCore/QuartzCore.h>
#import <libkern/OSAtomic.h>
#import <UIKit/UIKit.h>

@interface HQAnimationEngineItem : NSObject

@property (nonatomic, strong) DPHAnimation *animation;

@property (nonatomic, weak) id obj;

@property (nonatomic, copy) NSString *key;

@end

@implementation HQAnimationEngineItem

- (instancetype)initWithAnimation:(DPHAnimation *)anim Object:(id)obj AndKey:(NSString *)key
{
    self = [super init];
    if (!self) return nil;
    
    _animation = anim;
    _obj = obj;
    _key = key;
    
    return self;
}

@end


@interface DPHAnimationEngine ()

@property (nonatomic) CADisplayLink *display;
@property (nonatomic, strong) NSMutableDictionary<id,NSMutableDictionary<NSString *,DPHAnimation *> *> *animationsDict;
@property (nonatomic, strong) NSMutableArray<HQAnimationEngineItem *> *itemArray;
@property (nonatomic) OSSpinLock lock;

@end

@implementation DPHAnimationEngine

static inline void spinLock(OSSpinLock *lock,dispatch_block_t block)
{
    OSSpinLockLock(lock);
    if (block) block();
    OSSpinLockUnlock(lock);
}

+ (instancetype)sharedAnimator
{
    static DPHAnimationEngine* _animator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _animator = [[DPHAnimationEngine alloc] init];
    });
    return _animator;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _animationsDict = [NSMutableDictionary dictionary];
    _itemArray = [NSMutableArray array];
    _lock = OS_SPINLOCK_INIT;
    [self.display addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    return self;
}

- (void)lock:(dispatch_block_t)block
{
    spinLock(&_lock,block);
}

- (void)_update:(CADisplayLink *)link
{
    if (self.itemArray.count == 0) {
        link.paused = YES;
        return;
    }
    
    CFTimeInterval current = CACurrentMediaTime();
    [self _renderWithTime:current];
}

- (void)_renderWithTime:(CFTimeInterval)time
{
    [self _renderWithTime:time items:_itemArray];
}

- (void)_renderWithTime:(CFTimeInterval)time items:(NSArray<HQAnimationEngineItem *> *)items
{
    for (HQAnimationEngineItem *item in items) {
        [self _renderWithTime:time item:item];
    }
}

- (void)_renderWithTime:(CFTimeInterval)time item:(HQAnimationEngineItem *)item
{
    DPHAnimationState *animationState = item.animation.animationState;
    if ([animationState isStart]) {
        
        if (time - animationState.beginTime > animationState.duration) {
            if (item.animation.completion) {
                item.animation.completion(item.animation,YES);
            }
            [self removeAinmatortItemWithAnimation:item.animation];
        }
        
        [animationState applyAnimationTime:item.obj time:time];
        if (animationState.valueType == DPHAnimationValueTypeRect) {
            
            NSValue *current = animationState.currentValue;
            
            DPHAnimationValueType type = animationState.valueType;
            
            if (type == DPHAnimationValueTypeRect) {
                [item.obj setFrame:[current CGRectValue]];
            } else if (type == DPHAnimationValueTypePoint) {
                [item.obj setPosition:[current CGPointValue]];
            }
        }
    }else {
        [animationState startIfNeed];
    }
    
}

- (void)addAnimation:(DPHAnimation *)anim forObject:(id)obj key:(NSString *)key
{
    if (!anim || !obj) return;
    
    NSMutableDictionary<NSString *,DPHAnimation *> *dict = [self.animationsDict objectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)[obj hash]]];
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        [self.animationsDict setObject:dict forKey:[NSString stringWithFormat:@"%lu",(unsigned long)[obj hash]]];
    } else {
        DPHAnimation *existedAnim = [dict objectForKey:key];
        if (existedAnim) {
            if (existedAnim == anim) return;
            [self removeAnimationForObject:obj key:key cleanupDict:NO];
        }
    }
    
    HQAnimationEngineItem *item = [[HQAnimationEngineItem alloc] initWithAnimation:anim Object:obj AndKey:key];
    [_itemArray addObject:item];
    
    if (self.display.paused == YES) {
        self.display.paused = NO;
    }
}

- (void)removeAnimationForObject:(id)obj key:(NSString *)key
{
    [self removeAnimationForObject:obj key:key cleanupDict:YES];
}

- (void)removeAnimationForObject:(id)obj key:(NSString *)key cleanupDict:(BOOL)cleanupDict
{
    NSMutableDictionary *dict = [self.animationsDict objectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)[obj hash]]];
    if (dict) {
        DPHAnimation *animation = [dict objectForKey:key];
        if (animation) {
            [dict removeObjectForKey:key];
            if (dict.count == 0 && cleanupDict) {
                [self.animationsDict removeObjectForKey:obj];
            }
            [self removeAinmatortItemWithAnimation:animation];
        }
        
    }
}

- (void)removeAinmatortItemWithAnimation:(DPHAnimation *)anim
{
    [self lock:^{
        if (self.itemArray.count == 0) return;
        NSMutableArray *array = [NSMutableArray array];
        for (HQAnimationEngineItem *item in self.itemArray) {
            if (item.animation != anim) {
                [array addObject:item];
            }
        }
        self.itemArray = array;
    }];
}

#pragma mark - getter
- (CADisplayLink *)display
{
    if (!_display) {
        _display = [CADisplayLink displayLinkWithTarget:self selector:@selector(_update:)];
        _display.frameInterval = 1;
        _display.paused = NO;
    }
    return _display;
}

@end
