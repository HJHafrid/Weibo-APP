//
//  myModel.m
//  项目2_微博
//
//  Created by mac57 on 16/8/4.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "myModel.h"

@implementation myModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"MYdescription" : @"description"
             };
}
@end
