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

@property (weak, nonatomic) IBOutlet ThemeLable *lable4;
@property (weak, nonatomic) IBOutlet ThemeLable *lable3;
@property (weak, nonatomic) IBOutlet ThemeLable *lable2;
@property (weak, nonatomic) IBOutlet ThemeLable *lable1;
@property (weak, nonatomic) IBOutlet ThemeLable *themeLable;
@property (weak, nonatomic) IBOutlet ThemeLable *swapLable;
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
- (void)viewWillAppear:(BOOL)animated
{
    ThemeManager *manager = [ThemeManager shareManager];
    _themeLable.text = manager.nowThemeName;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.imageName = @"bg_detail.jpg";
    [self.view insertSubview:bgImageView atIndex:0];
    
    _view1.imageName = @"more_icon_theme.png";
    _view2.imageName = @"more_icon_feedback.png";
    _view3.imageName = @"more_icon_draft.png";
    _view4.imageName = @"more_icon_about.png";
    
    _swapLable.colorName = @"More_Item_Text_color";
    _themeLable.colorName = @"More_Item_Text_color";
    _lable1.colorName = @"More_Item_Text_color";
    _lable2.colorName = @"More_Item_Text_color";
    _lable3.colorName = @"More_Item_Text_color";
    _lable4.colorName = @"More_Item_Text_color";
    
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
