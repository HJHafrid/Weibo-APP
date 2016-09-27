//
//  CellLayOut.h
//  项目2_微博
//
//  Created by mac57 on 16/8/3.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <Foundation/Foundation.h>
#define cellRowHeight 60
#define cellImageView 200
#define spaceWidth 10
#define ImageViewSpace 5

@interface CellLayOut : NSObject
@property (nonatomic, strong) WeiboModel *weibo;

@property (nonatomic, assign, readonly) CGRect weiboTextHeight;
@property (nonatomic, assign,readonly) CGRect weiboImageHeight;
+(instancetype)layoutWithWeibo:(WeiboModel *)weibo;

@property (nonatomic, assign, readonly) CGRect reWeiboTextFrame;
@property (nonatomic, assign, readonly) CGRect reWeiboImageFrame;

@property (nonatomic, assign, readonly) CGRect reWeiboDetailView;
- (CGFloat)cellHeight;

@property (nonatomic, strong, readonly)NSArray *imageFrameArray;
@end
