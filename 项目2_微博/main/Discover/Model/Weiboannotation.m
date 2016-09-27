//
//  Weiboannotation.m
//  项目2_微博
//
//  Created by mac57 on 16/8/10.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "Weiboannotation.h"

@implementation Weiboannotation
-(void)setWeiboModel:(WeiboModel *)weiboModel
{
    _weiboModel = weiboModel;
    
    //从微薄对象中 获取地理位置信息  填充的coordinate中
    NSDictionary *geo = _weiboModel.geo;
//    NSLog(@"%@", geo);
    //获取经纬度坐标点
    NSArray *coordinates = geo[@"coordinates"];
    if (coordinates.count == 2) {
        //纬度
        double lat = [[coordinates firstObject] doubleValue];
        //经度
        double lon = [[coordinates lastObject] doubleValue];
        
        _coordinate = CLLocationCoordinate2DMake(lat, lon);
    }
}
@end
