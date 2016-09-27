//
//  myModel.h
//  项目2_微博
//
//  Created by mac57 on 16/8/4.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myModel : NSObject
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSURL *profile_image_url;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *MYdescription;
@property (nonatomic, copy) NSString *domain;

@property (copy, nonatomic) NSString *followers_count;
@property (copy, nonatomic) NSString *friends_count;
@property (copy, nonatomic) NSString *statuses_count;

@end
