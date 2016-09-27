//
//  WeiboModel.m
//  项目2_微博
//
//  Created by mac57 on 16/8/2.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"

@implementation WeiboModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    NSString *weiboText = [self.text copy];
    
    NSString *regex = @"\\[\\w+\\]";
    NSArray *array = [weiboText componentsMatchedByRegex:regex];
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *emoticons = [[NSArray alloc] initWithContentsOfFile:filepath];
    for (NSString *str in array) {
        NSString *s = [NSString stringWithFormat:@"chs='%@'", str];
        NSPredicate *pre = [NSPredicate predicateWithFormat:s];
        NSArray *result = [emoticons filteredArrayUsingPredicate:pre];
        NSDictionary *dic = [result firstObject];
        if (dic == nil) {
            continue;
        }
        NSString *imageName = dic[@"png"];
        NSString *imageString = [NSString stringWithFormat:@"<image url = '%@'>", imageName];
        weiboText = [weiboText stringByReplacingOccurrencesOfString:str withString:imageString];
        NSLog(@"替换成功 %@", str);
    }
    self.text = [weiboText copy];
    return YES;
}
@end
