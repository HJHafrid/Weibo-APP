//
//  LocationViewController.h
//  项目2_微博
//
//  Created by mac57 on 16/8/8.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^LocationResultBlock)(NSDictionary *result);
@interface LocationViewController : BaseViewController
@property (nonatomic, copy) LocationResultBlock block;
- (void)addLocationResultBlock:(LocationResultBlock)block;
@end
