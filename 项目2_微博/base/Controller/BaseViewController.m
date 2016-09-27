//
//  BaseViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/7/29.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    ThemeImageView *bgView = [[ThemeImageView alloc] initWithFrame:self.view.bounds];
    bgView.imageName = @"bg_detail.jpg";
    [self.view insertSubview:bgView atIndex:0];
    [self createBackButton];
}
- (void)createBackButton
{
    if (self.navigationController.viewControllers.count >= 2) {
        ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 60, 44);
        button.backgroundViewName = @"titlebar_button_back_9.png";
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(action1) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = item;
    }
}
- (void)action1
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
