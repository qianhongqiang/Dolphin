//
//  DPHAnimationState.h
//  Pods
//
//  Created by qianhongqiang on 2017/5/15.
//
//

#import <Foundation/Foundation.h>

@class DPHAnimation;

typedef NS_ENUM(NSUInteger, DPHAnimationValueType) {
    DPHAnimationValueTypeUnkown = 0,
    DPHAnimationValueTypeInteger,
    DPHAnimationValueTypeFloat,
    DPHAnimationValueTypePoint,
    DPHAnimationValueTypeSize,
    DPHAnimationValueTypeRect,
    DPHAnimationValueTypeEdgeInsets,
    DPHAnimationValueTypeAffineTransform,
    DPHAnimationValueTypeTransform,
    DPHAnimationValueTypeRange,
    DPHAnimationValueTypeColor
};

@interface DPHAnimationState : NSObject

@property (nonatomic, assign) CFTimeInterval beginTime;

-(BOOL)isStart;

-(void)startIfNeed;

- (BOOL)applyAnimationTime:(id)obj time:(CFTimeInterval)time;

@property (nonatomic, strong) id fromValue;

@property (nonatomic, strong) id toValue;

@property (nonatomic, assign) CFTimeInterval duration;

@property (nonatomic, assign, readonly) DPHAnimationValueType valueType;

@property (nonatomic, strong, readonly) id currentValue;

@end
