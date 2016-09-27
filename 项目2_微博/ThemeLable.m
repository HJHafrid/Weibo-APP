//
//  ThemeLable.m
//  项目2_微博
//
//  Created by mac57 on 16/8/1.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "ThemeLable.h"

@implementation ThemeLable

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lableTheme) name:kThemePictureChange object:nil];
        
    }
    return self;
}
-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lableTheme) name:kThemePictureChange object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)setColorName:(NSString *)colorName
{
    _colorName = [colorName copy];
    [self lableTheme];
}
- (void)lableTheme
{
    UIColor *color = [[ThemeManager shareManager] colorWithName:_colorName];
    self.textColor = color;
}

@end
