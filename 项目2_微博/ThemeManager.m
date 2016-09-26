//
//  ThemeManager.m
//  项目2_微博
//
//  Created by mac57 on 16/7/30.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager
+ (ThemeManager *)shareManager
{
    static ThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[super allocWithZone:nil] init];
        }
    });
    return manager;
}
-(instancetype)init
{
    self = [super self];
    if (self) {
        _nowThemeName = @"cat";
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        _allThemes = [[NSDictionary alloc] initWithContentsOfFile:filepath];
    }
    return self;
}
-(id)copy
{
    return self;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self shareManager];
}
-(void)setNowThemeName:(NSString *)nowThemeName
{
    if (![_nowThemeName isEqualToString:nowThemeName]) {
        _nowThemeName = [nowThemeName copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemePictureChange object:nil];
        
    }
}

- (UIImage *)themeImageWithName:(NSString *)imageName
{
    NSString *name = [NSString stringWithFormat:@"Skins/%@/%@", _nowThemeName, imageName];
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

@end
