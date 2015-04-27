//
//  HQAnimationShowViewController.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/4/27.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQAnimationShowViewController.h"
#import "HQSpringFlipperAnimation.h"

@interface HQAnimationShowViewController()

@property (nonatomic, assign) HQAnimationType animationType;

@end

@implementation HQAnimationShowViewController

-(instancetype)initWithAnimationType:(HQAnimationType)animationType
{
    self= [super init];
    
    if (self) {
        _animationType = animationType;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (_animationType) {
        case HQAnimationSpringFlipper:
        {
            UIButton *flipperBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            [flipperBtn setImage:[UIImage imageNamed:@"testImage"] forState:UIControlStateNormal];
            [flipperBtn addTarget:self action:@selector(flipperAnimation:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:flipperBtn];
            
            UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 100, 100)];
            [self.view addSubview:tip];
            tip.text = @"点击泡泡";
            tip.textAlignment = NSTextAlignmentCenter;
            tip.textColor = [UIColor purpleColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250, 100, 100, 100)];
            [self.view addSubview:label];
            label.text = @"duang~~";
            label.textColor = [UIColor purpleColor];
        }
            break;
        case HQAnimationRoundedRect:
        {
            UIButton *flipperBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            [flipperBtn setImage:[UIImage imageNamed:@"testImage"] forState:UIControlStateNormal];
            [flipperBtn addTarget:self action:@selector(roundedRect:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:flipperBtn];
            
            UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 100, 100)];
            [self.view addSubview:tip];
            tip.text = @"点击泡泡";
            tip.textAlignment = NSTextAlignmentCenter;
            tip.textColor = [UIColor purpleColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250, 100, 100, 100)];
            [self.view addSubview:label];
            label.text = @"duang~~";
            label.textColor = [UIColor purpleColor];
        }
            break;
            
        default:
            break;
    }
}

-(void)flipperAnimation:(UIButton *)sender
{
    HQSpringFlipperAnimation *springFlipper = [HQSpringFlipperAnimation springFlipper];

    [sender.layer addAnimation:springFlipper forKey:nil];
}

-(void)roundedRect:(UIButton *)sender
{
    
}

@end
