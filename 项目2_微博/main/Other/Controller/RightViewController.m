//
//  RightViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/8/1.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "RightViewController.h"
#import "SendWeiboViewController.h" 
#import "BaseNavigationController.h"    
#import "UIViewController+MMDrawerController.h"

@interface RightViewController ()

@end

@implementation RightViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButtons];
    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.imageName = @"mask_bg.jpg";
    
    [self.view insertSubview:bgImageView atIndex:0];
}
-(void)createButtons
{
    CGFloat buttonWidth = 50;
    CGFloat space = 15;
    for (int i = 0; i < 5; i++) {
        CGRect frame = CGRectMake(space, i * (space + buttonWidth) + 64, buttonWidth, buttonWidth);
        ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
        button.frame = frame;
        [self.view addSubview:button];
        NSString *imageName = [NSString stringWithFormat:@"newbar_icon_%i.png", i + 1];
        button.buttonName = imageName;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
    }
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mapButton.frame = CGRectMake(space, 0, buttonWidth, buttonWidth);
    [mapButton setImage:[UIImage imageNamed:@"btn_map_location"] forState:UIControlStateNormal];
    [self.view addSubview:mapButton];
    
    UIButton *qrButton = [UIButton buttonWithType:UIButtonTypeCustom];
    qrButton.frame = CGRectMake(space, 0, buttonWidth, buttonWidth);
    [qrButton setImage:[UIImage imageNamed:@"qr_btn"] forState:UIControlStateNormal];
    [self.view addSubview:qrButton];
    
    qrButton.bottom = ksHeight - 64 - space;
    mapButton.bottom = qrButton.top;
}
- (void)buttonAction:(UIButton *)button {
    if (button.tag == 0) {
        //发微博
        //创建发微博界面
        SendWeiboViewController *sendWeiboVC = [[SendWeiboViewController alloc] init];
        BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:sendWeiboVC];
        
        //模态视图弹出
        [self presentViewController:navi animated:YES completion:^{
            //获取MMDrawController
            MMDrawerController *mmd = self.mm_drawerController;
            
            //关闭侧边栏
            [mmd closeDrawerAnimated:YES completion:nil];
            
        }];
        
    }
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
