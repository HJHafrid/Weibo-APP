//
//  BaseNavigationController.m
//  项目2_微博
//
//  Created by mac57 on 16/7/29.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (kSystemVersion >= 7.0) {
//        ThemeImageView *navImage = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, -20, ksWidth, 64)];
//        navImage.imageName = @"mask_titlebar64@2x.png";
//        [self.navigationBar insertSubview:navImage atIndex:1];
//    }
//    else{
//        ThemeImageView *navImage = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, ksWidth, 44)];
//        navImage.imageName = @"mask_titlebar@2x.png";
//        [self.navigationBar insertSubview:navImage atIndex:1];
//    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navChange) name:kThemePictureChange object:nil];
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:25], NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = attributes;
    
    [self navChange];
}
- (void)navChange
{
    NSString *imageName;
    if (kSystemVersion >= 7.0) {
        imageName = @"mask_titlebar64@2x.png";
    }
    else
    {
        imageName = @"mask_titlebar@2x.png";
    }
    UIImage *image = [[ThemeManager shareManager] themeImageWithName:imageName];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
