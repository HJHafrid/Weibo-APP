//
//  WeiboModel.h
//  项目2_微博
//
//  Created by mac57 on 16/8/2.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface WeiboModel : NSObject
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, assign) NSInteger weiboID;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *in_reply_to_user_id;
@property (nonatomic, copy) NSString *in_reply_to_screen_name;
@property (nonatomic, strong)UserModel *user;
@property (nonatomic, strong)WeiboModel *retweeted_status;
@property (assign, nonatomic)   NSInteger   reposts_count;     //转发数
@property (assign, nonatomic)   NSInteger   comments_count;    //评论数
@property (assign, nonatomic)   NSInteger   attitudes_count;   //点赞数
@property (copy, nonatomic)     NSURL       *thumbnail_pic;     //缩略图片地址
@property (copy, nonatomic)     NSURL       *bmiddle_pic;       //中等尺寸图片地址
@property (copy, nonatomic)     NSURL       *original_pic;      //原始图片地址
@property (copy, nonatomic)     NSArray     *pic_urls;          //多图地址
@property (copy, nonatomic)     NSDictionary *geo;

@end
