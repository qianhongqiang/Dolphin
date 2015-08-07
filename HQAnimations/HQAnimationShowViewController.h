//
//  HQAnimationShowViewController.h
//  HQAnimations
//
//  Created by qianhongqiang on 15/4/27.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HQAnimationType) {
    HQAnimationSpringFlipper = 0,//带有弹簧性质的翻转
    HQAnimationMovingBubble,
    HQAnimationPop,
    HQAnimationShake,
    HQAnimationStroke,
};



@interface HQAnimationShowViewController : UIViewController

-(instancetype)initWithAnimationType:(HQAnimationType)animationType;

@end
