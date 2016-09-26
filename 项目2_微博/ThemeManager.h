//
//  ThemeManager.h
//  项目2_微博
//
//  Created by mac57 on 16/7/30.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeButton.h"
@interface ThemeManager : NSObject

@property (nonatomic, copy)NSString *nowThemeName;
@property (nonatomic, copy) NSDictionary *allThemes;
+ (ThemeManager *)shareManager;
- (UIImage *)themeImageWithName:(NSString *)imageName;
@end
