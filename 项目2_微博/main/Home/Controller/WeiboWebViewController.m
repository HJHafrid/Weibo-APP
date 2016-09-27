//
//  WeiboWebViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/8/6.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "WeiboWebViewController.h"

@interface WeiboWebViewController ()

@end

@implementation WeiboWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ksWidth, ksHeight - 64)];
    [self.view addSubview:web];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.url];
    [web loadRequest:request];
    
}
-(instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
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
