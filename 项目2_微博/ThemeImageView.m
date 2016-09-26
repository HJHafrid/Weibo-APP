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
-(void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    [self themeChange];
}
- (void)themeChange
{
    ThemeManager *manager = [ThemeManager shareManager];
    self.image = [manager themeImageWithName:self.imageName];
}

@end
