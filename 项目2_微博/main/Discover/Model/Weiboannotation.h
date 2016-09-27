//
//  Weiboannotation.h
//  项目2_微博
//
//  Created by mac57 on 16/8/10.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"
#import <MapKit/MapKit.h>
@interface Weiboannotation : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//可选的
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;

//微博对象
@property (nonatomic, strong, nullable) WeiboModel *weiboModel;
@end
