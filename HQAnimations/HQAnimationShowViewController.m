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
#import "HQSpringAnimation.h"
#import "HQSpringTransformAnimation.h"

#import "HQPOP.h"
#import "HQBasicAnimation.h"

@interface HQAnimationShowViewController()

@property (nonatomic, assign) HQAnimationType animationType;

@property (nonatomic,strong) HQStrokeButton *strokeBtn;

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
    [closeVC setBackgroundImage:nil forState:UIControlStateHighlighted];
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
        case HQAnimationShake:
        {
            UIButton *popBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            [popBtn setImage:[UIImage imageNamed:@"testImage"] forState:UIControlStateNormal];
            [popBtn addTarget:self action:@selector(shakeAnimation:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:popBtn];
            
            UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 100, 100)];
            [self.view addSubview:tip];
            tip.text = @"点击泡泡";
            tip.textAlignment = NSTextAlignmentCenter;
            tip.textColor = [UIColor purpleColor];
        }
            break;
        case HQAnimationStroke:
        {
            self.strokeBtn = [[HQStrokeButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            [self.strokeBtn addTarget:self action:@selector(clockAnimation:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.strokeBtn];
            
            UIButton *popBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
            popBtn.backgroundColor = [UIColor yellowColor];
            [popBtn addTarget:self action:@selector(btnChanged:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:popBtn];
        }
            break;
        case HQAnimationSpringMoving:
        {
            UIButton *popBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            [popBtn setImage:[UIImage imageNamed:@"testImage"] forState:UIControlStateNormal];
            [popBtn addTarget:self action:@selector(springMoving:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:popBtn];
            
            UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 100, 100)];
            [self.view addSubview:tip];
            tip.text = @"点击泡泡";
            tip.textAlignment = NSTextAlignmentCenter;
            tip.textColor = [UIColor purpleColor];
            
        }
            break;
        case HQAnimationTest:
        {
            UIButton *popBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            [popBtn setImage:[UIImage imageNamed:@"testImage"] forState:UIControlStateNormal];
            
            [popBtn addTarget:self action:@selector(newPop:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:popBtn];
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

-(void)clockAnimation:(UISlider *)sender {
    
}

-(void)shakeAnimation:(UIButton *)sender {
    HQShakeAnimation *pop = [HQShakeAnimation shake];
    
    [sender.layer addAnimation:pop forKey:nil];
}

- (void)newPop:(UIButton *)sender
{
    if (sender.selected == YES) {
        sender.selected = NO;
        
        HQBasicAnimation *test = [[HQBasicAnimation alloc] init];
        
        test.fromValue =  [NSValue valueWithCGRect:sender.frame];
        test.toValue = [NSValue valueWithCGRect:CGRectMake(100, 100, 100, 100)];
        test.duration = 1;
        
        [sender qhq_addAnimation:test forKey:@"dd"];
        
        return;
    }
    
    sender.selected = YES;
    
    HQBasicAnimation *test = [[HQBasicAnimation alloc] init];
    
    test.fromValue =  [NSValue valueWithCGRect:sender.frame];
    test.toValue = [NSValue valueWithCGRect:CGRectMake(300, 300, 100, 100)];
    test.duration = 1;
    
    [sender qhq_addAnimation:test forKey:@"dd"];
}

static int test  = 1;

-(void)slideChanged:(UISlider *)sender {
    [self.strokeBtn springSetSroke:sender.value];
}

-(void)btnChanged:(UIButton *)sender {
    if (test == 1) {
        [self.strokeBtn springSetSroke:0.5];
        test = 2;
    }else {
        
        [self.strokeBtn springSetSroke:0.8];
        test = 1;
    }
}

-(void)springMoving:(UIButton *)sender {
    [sender hq_addAnimation:HQAnimationInstance.damp(3).accelerate(3).durationV(1.5).fromPoint(sender.center).toPoint(CGPointMake(150, sender.center.y == 450 ? 150 : 450)) forKey:nil];
}


-(void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"%@",anim);
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%@",anim);
}



-(void)closeVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
