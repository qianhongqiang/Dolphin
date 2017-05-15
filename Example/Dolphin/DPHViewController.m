//
//  DPHViewController.m
//  Dolphin
//
//  Created by qianhongqiang2012@163.com on 05/15/2017.
//  Copyright (c) 2017 qianhongqiang2012@163.com. All rights reserved.
//

#import "DPHViewController.h"
#import <Dolphin/Dolphin.h>

@interface DPHViewController ()

@end

@implementation DPHViewController

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
        
        sender.frame = CGRectMake(100, 100, 100, 100);
        
        return;
    }
    
    sender.selected = YES;
    NSLog(@"------%f",[NSDate date].timeIntervalSince1970);
    DPHBasicAnimation *test = [[DPHBasicAnimation alloc] init];
    
    test.fromValue =  [NSValue valueWithCGRect:sender.frame];
    test.toValue = [NSValue valueWithCGRect:CGRectMake(300, 100, 100, 100)];
    test.duration = 1;
    
    test.completion = ^(DPHAnimation *animation, BOOL isfinished) {
        if (isfinished) {
            NSLog(@"------%f",[NSDate date].timeIntervalSince1970);
        }
    };
    
    [sender dph_addAnimation:test forKey:@"dd"];
}

@end
