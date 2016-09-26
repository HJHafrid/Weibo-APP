//
//  MoreViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/7/29.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "MoreViewController.h"
#import "AppDelegate.h"
@interface MoreViewController ()
@property (weak, nonatomic) IBOutlet ThemeImageView *view1;
@property (weak, nonatomic) IBOutlet ThemeImageView *view2;
@property (weak, nonatomic) IBOutlet ThemeImageView *view3;
@property (weak, nonatomic) IBOutlet ThemeImageView *view4;

@end

@implementation MoreViewController
- (IBAction)logout:(id)sender {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate logoutWeibo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _view1.imageName = @"more_icon_theme.png";
    _view2.imageName = @"more_icon_feedback.png";
    _view3.imageName = @"more_icon_draft.png";
    _view4.imageName = @"more_icon_about.png";
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
