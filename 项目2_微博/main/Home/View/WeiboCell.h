//@property (strong, nonatomic) UILabel *weiboTextLabel;
//  WeiboCell.h
//  项目2_微博
//
//  Created by mac57 on 16/8/2.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ThemeLable *mSource;
@property (weak, nonatomic) IBOutlet ThemeLable *mTime;
@property (weak, nonatomic) IBOutlet UIImageView *mView;
@property (weak, nonatomic) IBOutlet ThemeLable *mName;
@property (nonatomic, strong) WeiboModel *weiboModel;
@end
