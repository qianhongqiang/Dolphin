//
//  DPHAnimation.h
//  Pods
//
//  Created by qianhongqiang on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import "DPHAnimationState.h"

@interface DPHAnimation : NSObject

@property (nonatomic, strong) DPHAnimationState *animationState;

@end

@interface NSObject (Dolphin)

- (void)dph_addAnimation:(DPHAnimation *)anim forKey:(NSString *)key;

@end
