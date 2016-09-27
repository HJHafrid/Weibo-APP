//
//  DisCoverViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/7/29.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "DisCoverViewController.h"
#import "NearbyUserViewController.h"
@interface DisCoverViewController ()

@end

@implementation DisCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)nearbyButton:(id)sender {
    NearbyUserViewController *nearby = [[NearbyUserViewController alloc] init];
    nearby.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nearby animated:YES];
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
