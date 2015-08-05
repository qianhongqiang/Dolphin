//
//  HQAnimationShowViewController.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/4/27.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQAnimationShowViewController.h"
#import "HQSpringFlipperAnimation.h"
#import "HQEllipticAnimationButton.h"
#import "HQPopAnimation.h"

#import "HQTimingFunctionMath.h"

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
    
    UIButton *closeVC = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 50, 30)];
    [closeVC setTitle:@"关闭" forState:UIControlStateNormal];
    [closeVC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeVC addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeVC];
    
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
        case HQAnimationMovingBubble:
        {
            HQEllipticAnimationButton *ellipticBtn = [[HQEllipticAnimationButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            [self.view addSubview:ellipticBtn];
            
            UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 100, 100)];
            [self.view addSubview:tip];
            tip.text = @"仔细看泡泡";
            tip.textAlignment = NSTextAlignmentCenter;
            tip.textColor = [UIColor purpleColor];
        }
            break;
        case HQAnimationPop:
        {
            UIButton *popBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            [popBtn setImage:[UIImage imageNamed:@"testImage"] forState:UIControlStateNormal];
            [popBtn addTarget:self action:@selector(popAnimation:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:popBtn];
            
            UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 100, 100)];
            [self.view addSubview:tip];
            tip.text = @"点击泡泡";
            tip.textAlignment = NSTextAlignmentCenter;
            tip.textColor = [UIColor purpleColor];
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

-(void)popAnimation:(UIButton *)sender {
    HQPopAnimation *pop = [HQPopAnimation pop];
    
    [sender.layer addAnimation:pop forKey:nil];
}

-(void)closeVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
