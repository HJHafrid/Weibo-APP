//
//  SendWeiboViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/8/8.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "SendWeiboViewController.h"
#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "HomeViewController.h"
#import "LocationViewController.h"
#import "SinaWeibo+SendWeibo.h"
#import "MBProgressHUD.h"
#import "EmoticonInputView.h"
#define kToolViewHeight 40
#define kLocationViewHeight 20
#define kSendWeiboAPI @"statuses/update.json"
#define kSengWeiboWithImageAPI @"statuses/upload.json"

@interface SendWeiboViewController ()<SinaWeiboRequestDelegate>
{
    UITextView *_inputTextView;
    UIView *_toolView;
    
    UIView *_locationView;
    UIImageView *_locationIconImageView;
    ThemeLable *_locationNameLable;
    ThemeButton *_locationCancelButton;
    EmoticonInputView *_emticonView;
}
@property (nonatomic, strong) NSDictionary *locationData;

@end

@implementation SendWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写微博";
    [self createNavgationBarButton];
    [self createInputView];
    [self createToolView];
    [self createLocationViews];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)createInputView
{
    _inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, ksWidth, ksHeight - kToolViewHeight - 64)];
    _inputTextView.backgroundColor = [UIColor orangeColor];
    _inputTextView.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:_inputTextView];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [center addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
}
- (void)createToolView
{
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ksWidth, kToolViewHeight)];
    _toolView.top = _inputTextView.bottom;
    _toolView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_toolView];
    
    for (int i = 0; i < 5; i++) {
        CGRect frame = CGRectMake((ksWidth / 5 - 40) / 2 + ksWidth / 5 * i, 3.5, 40, 33);
        ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
        button.frame = frame;
        [_toolView addSubview:button];
        NSArray *array = @[@"compose_toolbar_1", @"compose_toolbar_3", @"compose_toolbar_4", @"compose_toolbar_5", @"compose_toolbar_6"];
        button.buttonName = array[i];
        button.tag = i;
        [button addTarget:self action:@selector(toolBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)createNavgationBarButton
{
    //取消
    ThemeButton *leftButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 60, 44);
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    leftButton.backgroundViewName = @"titlebar_button_9.png";
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    //发送
    ThemeButton *rightButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    [rightButton setTitle:@"发送" forState:UIControlStateNormal];
    rightButton.backgroundViewName = @"titlebar_button_9.png";
    [rightButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createLocationViews
{
    _locationView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ksWidth - 10, kLocationViewHeight)];
    [self.view addSubview:_locationView];
    _locationView.bottom = _toolView.top;
    _locationIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kLocationViewHeight, kLocationViewHeight)];
    [_locationView addSubview:_locationIconImageView];
    _locationNameLable = [[ThemeLable alloc] initWithFrame:CGRectMake(kLocationViewHeight, 0, 200, kLocationViewHeight)];
    _locationNameLable.colorName = kMoreItemTextColor;
    _locationNameLable.text = @"杭州职业技术学院";
    [_locationView addSubview:_locationNameLable];
    _locationCancelButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    _locationCancelButton.frame = CGRectMake(0, 0, kLocationViewHeight, kLocationViewHeight);
    _locationCancelButton.left = _locationNameLable.right;
    _locationCancelButton.backgroundViewName = @"compose_toolbar_clear.png";
    [_locationView addSubview:_locationCancelButton];
    [_locationCancelButton addTarget:self action:@selector(locationCancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _locationView.hidden = YES;
}
- (void)locationCancelButtonAction
{
    self.locationData = nil;
}

- (void)backAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)sendAction {
    NSString *text = [_inputTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"没有输入微博正文" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:hud];
    hud.labelText = @"正在发送";
    hud.dimBackground = YES;
    [hud show:YES];
    
    SinaWeibo *wb = kSinaWeiBoObject;
    NSMutableDictionary *params = [@{@"status" : text} mutableCopy];
    if (self.locationData) {
        NSString *lon = self.locationData[@"lon"];
        NSString *lat = self.locationData[@"lat"];
        [params setObject:lon forKey:@"long"];
        [params setObject:lat forKey:@"lat"];
    }
//    [wb requestWithURL:kSendWeiboAPI params:params httpMethod:@"POST" delegate:self];
    [wb sendWeiboWithText:text image:nil params:params success:^(id result) {
        [_inputTextView resignFirstResponder];
        
        //返回前一页面
        [self dismissViewControllerAnimated:YES completion:^{
            //刷新微博
            UIApplication *app = [UIApplication sharedApplication];
            AppDelegate *delegate = (AppDelegate *)app.delegate;
            MMDrawerController *mmd = (MMDrawerController *)delegate.window.rootViewController;
            UITabBarController *tabbar = (UITabBarController *)mmd.centerViewController;
            UINavigationController *navi = (UINavigationController *)[tabbar.viewControllers firstObject];
            
            HomeViewController *home = (HomeViewController *)navi.topViewController;
            hud.labelText = @"发送成功";
            [hud hide:YES afterDelay:0.5];
            
            [home reloadNewWeibo];
            
        }];
    } fail:^(NSError *error) {
        NSLog(@"失败");
    }];
}
- (void)toolBarButtonAction:(UIButton *)button
{
    if (button.tag == 3) {
        LocationViewController *location = [[LocationViewController alloc] init];
        [location addLocationResultBlock:^(NSDictionary *result) {
            self.locationData = result;
        }];
        [self.navigationController pushViewController:location animated:YES];
    }
    else if (button.tag == 4)
    {
        if (_emticonView == nil) {
            _emticonView = [[EmoticonInputView alloc] initWithFrame:CGRectMake(0, 0, ksWidth, 0)];
        }
        _inputTextView.inputView = _inputTextView.inputView ? nil : _emticonView;
        [_inputTextView reloadInputViews];
        [_inputTextView becomeFirstResponder];
        
    }
}
- (void)keyboardFrameChanged:(NSNotification *)notification
{
    NSValue *value = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];
    _inputTextView.height = ksHeight - kToolViewHeight - keyboardFrame.size.height - 64;
    _toolView.top = _inputTextView.bottom;
    _locationView.bottom = _toolView.top;
}
- (void)keyboardHide:(NSNotification *)notification
{
    _inputTextView.height = ksHeight - 64 - kToolViewHeight;
    _toolView.top = _inputTextView.bottom;
    _locationView.bottom = _toolView.top;
}
//- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response {
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    
//    if (httpResponse.statusCode == 200) {
//        NSLog(@"发送成功");
//        //收起键盘
//        [_inputTextView resignFirstResponder];
//        
//        //返回前一页面
//        [self dismissViewControllerAnimated:YES completion:^{
//            //刷新微博
//            UIApplication *app = [UIApplication sharedApplication];
//            AppDelegate *delegate = (AppDelegate *)app.delegate;
//            MMDrawerController *mmd = (MMDrawerController *)delegate.window.rootViewController;
//            UITabBarController *tabbar = (UITabBarController *)mmd.centerViewController;
//            UINavigationController *navi = (UINavigationController *)[tabbar.viewControllers firstObject];
//            
//            HomeViewController *home = (HomeViewController *)navi.topViewController;
//            
//            [home reloadNewWeibo];
//            
//        }];
//    }
//}
-(void)setLocationData:(NSDictionary *)locationData
{
    if (_locationData != locationData) {
        _locationData = [locationData copy];
        if (_locationData == nil) {
            //点击取消按钮  将LocationData设置为空
            _locationView.hidden = YES;
        } else {
            _locationView.hidden = NO;
            //设置数据
            _locationNameLable.text = _locationData[@"title"];
            [_locationIconImageView sd_setImageWithURL:[NSURL URLWithString:_locationData[@"icon"]]];
            
            //改变Label宽度
            NSDictionary *attributes = @{NSFontAttributeName : _locationNameLable.font};
            CGRect rect = [_locationNameLable.text boundingRectWithSize:CGSizeMake(kScreenWidth - 10 - kLocationViewHeight * 2, kLocationViewHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
            CGFloat width = rect.size.width;
            
            _locationNameLable.width = width;
            _locationCancelButton.left = _locationNameLable.right;
        }
        
        
    }
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
