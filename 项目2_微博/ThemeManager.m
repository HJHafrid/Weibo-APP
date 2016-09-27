//
//  ThemeManager.m
//  项目2_微博
//
//  Created by mac57 on 16/7/30.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "ThemeManager.h"
#define kCurrentThemeNameKey @"kCurrentThemeNameKey"
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
        _nowThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentThemeNameKey];
        if (_nowThemeName == nil) {
            _nowThemeName = @"Village";
        }
        
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        _allThemes = [[NSDictionary alloc] initWithContentsOfFile:filepath];
        [self loadColorfile];
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
    if (!_allThemes[nowThemeName]) {
        return;
    }
    if (![_nowThemeName isEqualToString:nowThemeName]) {
        _nowThemeName = [nowThemeName copy];
        [self loadColorfile];
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemePictureChange object:nil];
        [[NSUserDefaults standardUserDefaults] setObject:_nowThemeName forKey:kCurrentThemeNameKey];
        
    }
}
-(void)loadColorfile
{
    NSString *filePath = [[NSBundle mainBundle] resourcePath];
    NSLog(@"%@", filePath);
    NSString *filepath1 = [NSString stringWithFormat:@"%@/%@/config.plist", filePath, _allThemes[_nowThemeName]];
    _wordsThemeChange = [[NSDictionary alloc] initWithContentsOfFile:filepath1];
}


- (UIImage *)themeImageWithName:(NSString *)imageName
{
    NSString *name = [NSString stringWithFormat:@"%@/%@", _allThemes[_nowThemeName], imageName];
    UIImage *image = [UIImage imageNamed:name];
    return image;
}
-(UIColor *)colorWithName:(NSString *)colorName
{
    NSDictionary *colorDic = _wordsThemeChange[colorName];
    if (colorDic == nil) {
        return [UIColor blackColor];
    }
//    NSString *red = [NSString stringWithFormat:[colorName[@"R"] doubleValue]];
    CGFloat red = [colorDic[@"R"] doubleValue];
    CGFloat green = [colorDic[@"G"] doubleValue];
    CGFloat blue = [colorDic[@"B"] doubleValue];
    UIColor *color = [UIColor colorWithRed:red / 255.0 green:green / 255 blue:blue / 255 alpha:1];
    return color;
}

@end
