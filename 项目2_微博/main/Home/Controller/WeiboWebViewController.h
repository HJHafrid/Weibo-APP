//
//  WeiboWebViewController.h
//  项目2_微博
//
//  Created by mac57 on 16/8/6.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "BaseViewController.h"

@interface WeiboWebViewController : BaseViewController
@property (nonatomic, strong) NSURL *url;
- (instancetype)initWithURL:(NSURL *)url;
@end
