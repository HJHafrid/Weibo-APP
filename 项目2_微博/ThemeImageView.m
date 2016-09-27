//
//  ThemeImageView.m
//  项目2_微博
//
//  Created by mac57 on 16/7/30.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "ThemeImageView.h"

@implementation ThemeImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftCapWidth = 0;
        self.topCapHeight = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:kThemePictureChange object:nil];
    }
    return self;
}
-(void)awakeFromNib
{
    self.leftCapWidth = 0;
    self.topCapHeight = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:kThemePictureChange object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    [self themeChange];
}
- (void)themeChange
{
    ThemeManager *manager = [ThemeManager shareManager];
    UIImage *image = [manager themeImageWithName:self.imageName];
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    
    self.image = image;
}
-(void)setLeftCapWidth:(CGFloat)leftCapWidth
{
    _leftCapWidth = leftCapWidth;
    [self themeChange];
}
-(void)setTopCapHeight:(CGFloat)topCapHeight
{
    _topCapHeight = topCapHeight;
    [self themeChange];
}

@end
