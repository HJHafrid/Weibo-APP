//
//  ThemeButton.m
//  项目2_微博
//
//  Created by mac57 on 16/7/30.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "ThemeButton.h"

@implementation ThemeButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:kThemePictureChange object:nil];
    }
    return self;

}
-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:kThemePictureChange object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setBackgroundViewName:(NSString *)backgroundViewName
{
    _backgroundViewName = backgroundViewName;
    [self themeChange];
}
-(void)setButtonName:(NSString *)buttonName
{
    _buttonName = buttonName;
    [self themeChange];
}
-(void)themeChange
{
    UIImage *image = [[ThemeManager shareManager] themeImageWithName:_buttonName];
    UIImage *bkimage = [[ThemeManager shareManager] themeImageWithName:_backgroundViewName];
    [self setImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:bkimage forState:UIControlStateNormal];
}
@end
