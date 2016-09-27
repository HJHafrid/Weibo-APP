//
//  ThemeImageView.h
//  项目2_微博
//
//  Created by mac57 on 16/7/30.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView
@property (nonatomic, copy) NSString *imageName;
//拉伸参数
@property (nonatomic, assign) CGFloat leftCapWidth;
@property (nonatomic, assign) CGFloat topCapHeight;
@end
