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

+ (id)sharedAnimator
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
    DPHAnimation *animation = item.animation;
    if ([animation.animationState isStart]) {
        [animation.animationState applyAnimationTime:item.obj time:time];
        if (animation.animationState.valueType == DPHAnimationValueTypeRect) {
            
            NSValue *current = animation.animationState.currentValue;
            
            [item.obj setFrame:[current CGRectValue]];
        }
    }else {
        [animation.animationState startIfNeed];
    }
    
}

- (void)addAnimation:(DPHAnimation *)anim forObject:(id)obj key:(NSString *)key
{
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
    
    HQAnimationEngineItem *item = [[HQAnimationEngineItem alloc] init];
    item.animation = anim;
    item.obj = obj;
    item.key = key;
    
    [_itemArray addObject:item];
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
