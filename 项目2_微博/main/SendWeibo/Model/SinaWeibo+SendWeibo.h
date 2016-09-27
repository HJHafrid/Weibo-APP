//
//  SinaWeibo+SendWeibo.h
//  项目2_微博
//
//  Created by mac57 on 16/8/9.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "SinaWeibo.h"
typedef void(^SendWeiboSuccessBlock)(id result);
typedef void(^SendWeiboFailBlock)(NSError *error);
@interface SinaWeibo (SendWeibo)
- (void)sendWeiboWithText:(NSString *)text
                    image:(UIImage *)image
                   params:(NSDictionary *)parmas
                  success:(SendWeiboSuccessBlock)success
                     fail:(SendWeiboFailBlock)fail;
@end
