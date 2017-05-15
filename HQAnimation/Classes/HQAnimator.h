//
//  HQAnimator.h
//  HQAnimations
//
//  Created by qianhongqiang on 2017/5/11.
//  Copyright © 2017年 QianHongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQAnimation.h"

@interface HQAnimator : NSObject

+ (id)sharedAnimator;

- (void)addAnimation:(HQAnimation *)anim forObject:(id)obj key:(NSString *)key;

@end
