//
//  WeiboAnnotationView.m
//  项目2_微博
//
//  Created by mac57 on 16/8/10.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "Weiboannotation.h"

@implementation WeiboAnnotationView
-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"创建标注视图");
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    bgImageView.image = [UIImage imageNamed:@"nearby_map_people_bg.png"];
    [self addSubview:bgImageView];
    
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 50, 50)];
    userImageView.backgroundColor = [UIColor blackColor];
    userImageView.layer.cornerRadius = 3;
    userImageView.layer.masksToBounds = YES;
    [bgImageView addSubview:userImageView];
    bgImageView.frame = CGRectMake(-35, -70, 70, 70);
    Weiboannotation *annotation = self.annotation;
    WeiboModel *model = annotation.weiboModel;
    NSURL *url = model.user.profile_image_url;
    [userImageView sd_setImageWithURL:url];
}
@end
