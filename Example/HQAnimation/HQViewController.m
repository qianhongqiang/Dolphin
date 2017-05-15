//
//  HQViewController.m
//  HQAnimation
//
//  Created by qianhongqiang2012@163.com on 05/15/2017.
//  Copyright (c) 2017 qianhongqiang2012@163.com. All rights reserved.
//

#import "HQViewController.h"
#import <HQAnimation/HQBasicAnimation.h>

@interface HQViewController ()

@end

@implementation HQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *popBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    popBtn.backgroundColor = [UIColor blueColor];
    [popBtn setTitle:@"测试按钮" forState:UIControlStateNormal];
    
    [popBtn addTarget:self action:@selector(newPop:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:popBtn];
    
    
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


@end
