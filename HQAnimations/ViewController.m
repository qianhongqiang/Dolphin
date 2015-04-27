//
//  ViewController.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/4/27.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "ViewController.h"
#import "HQAnimationShowViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *animaitions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.animaitions = @[@"springFlipper",@"movingBubble"];
    
    UITableView *animationListView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    animationListView.rowHeight = 50;
    animationListView.showsVerticalScrollIndicator = NO;
    animationListView.delegate = self;
    animationListView.dataSource = self;
    [self.view addSubview:animationListView];
}

#pragma -mark tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animaitions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"animaitions";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = self.animaitions[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQAnimationShowViewController *showVC = [[HQAnimationShowViewController alloc] initWithAnimationType:indexPath.row];
    [self presentViewController:showVC animated:YES completion:nil];
}

@end
