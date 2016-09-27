//
//  UserModel.h
//  项目2_微博
//
//  Created by mac57 on 16/8/2.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *descriptionWord;
@property (nonatomic, copy) NSURL *profile_image_url;
@property (nonatomic, copy) NSString *cover_image_phone;
@property (nonatomic, copy) NSString *create_at;

@property (nonatomic, assign) NSInteger favourites_count;
@property(nonatomic,copy)   NSString    *gender;



@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *MYdescription;

@property (copy, nonatomic) NSString *followers_count;
@property (copy, nonatomic) NSString *friends_count;
@property (copy, nonatomic) NSString *statuses_count;
@end
