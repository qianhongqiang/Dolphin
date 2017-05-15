//
//  HQAnimation.h
//  HQAnimations
//
//  Created by qianhongqiang on 2017/5/11.
//  Copyright © 2017年 QianHongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQAnimationState.h"

@interface HQAnimation : NSObject

@property (nonatomic, strong) HQAnimationState *animationState;

@end

@interface NSObject (HQAnimation)

- (void)qhq_addAnimation:(HQAnimation *)anim forKey:(NSString *)key;

@end
