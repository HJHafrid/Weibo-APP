//
//  ProCell.h
//  项目2_微博
//
//  Created by mac57 on 16/8/4.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture1;
@property (weak, nonatomic) IBOutlet ThemeLable *lable1;
@property (weak, nonatomic) IBOutlet ThemeLable *lable2;
@property (weak, nonatomic) IBOutlet ThemeLable *lable3;
@property (nonatomic, strong) myModel *myModel;

@end
