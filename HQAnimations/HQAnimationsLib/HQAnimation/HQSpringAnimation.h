//
//  HQSpringAnimation.h
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/8.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HQSpringAnimation : NSObject

/**@抽象属性
 *  keyPath属性,具体的属性可以在constant列表中查看
 */
@property (nonatomic, copy) NSString *keyPath;

/**@抽象属性
 *  延迟，动画将会延迟一定的时间执行
 */
@property (nonatomic, assign) CFTimeInterval delay;

/**@抽象属性
 *  动画的持续时间
 */
@property (nonatomic, assign) CFTimeInterval duration;

/**@抽象属性
 *  阻尼系数,参数范围(0-1),系数越大，增衰减越快
 */
@property (nonatomic, assign) double damping;

/**@抽象属性
 *  弹性,系数越大,震荡幅度越大,默认值1
 */
@property (nonatomic, assign) double springVelocity;

/**@抽象属性
 * 加速度,建议值[];
 */
@property (nonatomic, assign) double acceleration;

/**@抽象属性
 * 动画开始值
 */
@property (nonatomic, strong) NSValue *fromValue;

/**@抽象属性
 *  动画终止值
 */
@property (nonatomic, strong) NSValue *toValue;

/**@抽象属性
 *  动画中间值
 */
@property (nonatomic, strong, readonly) NSArray *values;

/**
 *  通过关键字初始化抽象动画实例
 *
 *  @param name 关键字,可在常量里
 */
+ (instancetype)animationWithPropertyNamed:(NSString *)name;

@end

@interface HQSpringAnimation (Bezier)

@property (nonatomic, assign) CGPoint test;

@end

@interface NSObject (HQSpring)

- (void)hq_addAnimation:(HQSpringAnimation *)anim forKey:(NSString *)key;
- (void)hq_removeAllAnimations;
- (void)hq_removeAnimationForKey:(NSString *)key;
- (NSArray *)hq_animationKeys;
- (id)hq_animationForKey:(NSString *)key;

@end

@interface CAKeyframeAnimation (HQSpringIdentifier)

@property (nonatomic, copy) NSString *identifier;

@end
