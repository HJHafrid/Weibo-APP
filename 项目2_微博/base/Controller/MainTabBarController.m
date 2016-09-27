//
//  MainTabBarController.m
//  项目2_微博
//
//  Created by mac57 on 16/7/29.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "MainTabBarController.h"


@interface MainTabBarController ()
{
    ThemeImageView *_selectView;
}

@end

@implementation MainTabBarController

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self createSubviewController];
        [self creatTabBarButton];
    }
    return self;
}

- (void)createSubviewController
{
    NSArray *strName = @[@"Home", @"Message", @"Discover", @"Profile", @"More"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (NSString *name in strName) {
        UIStoryboard *strBoard = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
        UINavigationController *navCtrl = [strBoard instantiateInitialViewController];
        [mArray addObject:navCtrl];
    }
    self.viewControllers = [mArray copy];
}

- (void)creatTabBarButton
{
    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, -2, ksWidth, 51)];
    bgImageView.imageName = @"mask_navbar@2x.png";
    [self.tabBar insertSubview:bgImageView atIndex:0];
    
    for (UIView *view in self.tabBar.subviews) {
        Class buttonClass = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:buttonClass]) {
            [view removeFromSuperview];
        }
    }
    CGFloat buttonWidth = ksWidth / 5;
    for (int i = 0; i < 5; i++) {
        NSString *picName = [NSString stringWithFormat:@"home_tab_icon_%i@2x.png", i + 1];
        ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(buttonWidth * i, 0, buttonWidth, 49);
        button.frame = frame;
        button.tag = i;
        [self.tabBar addSubview:button];
        button.buttonName = picName;
        [button addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    _selectView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 49)];
    _selectView.imageName = @"home_bottom_tab_arrow@2x.png";
    [self.tabBar insertSubview:_selectView atIndex:1];
    self.tabBar.shadowImage = [[UIImage alloc] init];
    
    
}
- (void)tabBarButtonAction:(UIButton *)button
{
    self.selectedIndex = button.tag;
    [UIView animateWithDuration:0.3 animations:^{
        _selectView.center = button.center;
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
