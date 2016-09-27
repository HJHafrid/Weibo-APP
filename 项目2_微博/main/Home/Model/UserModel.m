//
//  UserModel.m
//  项目2_微博
//
//  Created by mac57 on 16/8/2.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             //key Model类中属性的名字
             //value 字典中，属性对应的Key
             @"MYdescription" : @"description"
             };
    
}

@end
