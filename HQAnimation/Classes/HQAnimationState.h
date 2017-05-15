//
//  HQAnimationState.h
//  HQAnimations
//
//  Created by qianhongqiang on 2017/5/12.
//  Copyright © 2017年 QianHongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HQAnimationValueType) {
    HQAnimationValueTypeUnkown = 0,
    HQAnimationValueTypeInteger,
    HQAnimationValueTypeFloat,
    HQAnimationValueTypePoint,
    HQAnimationValueTypeSize,
    HQAnimationValueTypeRect,
    HQAnimationValueTypeEdgeInsets,
    HQAnimationValueTypeAffineTransform,
    HQAnimationValueTypeTransform,
    HQAnimationValueTypeRange,
    HQAnimationValueTypeColor
};

@interface HQAnimationState : NSObject

@property (nonatomic, assign) CFTimeInterval beginTime;

-(BOOL)isStart;

-(void)startIfNeed;

- (BOOL)applyAnimationTime:(id)obj time:(CFTimeInterval)time;

@property (nonatomic, strong) id fromValue;

@property (nonatomic, strong) id toValue;

@property (nonatomic, assign) CFTimeInterval duration;

@property (nonatomic, assign, readonly) HQAnimationValueType valueType;

@property (nonatomic, strong, readonly) id currentValue;

@end
