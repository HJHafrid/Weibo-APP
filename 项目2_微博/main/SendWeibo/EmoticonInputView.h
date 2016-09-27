//
//  EmoticonInputView.h
//  项目2_微博
//
//  Created by mac57 on 16/8/10.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kEmoticonWidth (kScreenWidth / 8)   //单个表情宽度
#define kPageControllerHeight 20 
#define kScrollViewHeight (kEmoticonWidth * 4)//页码显示器高度
#define kEmoticonInputViewHeight ((kEmoticonWidth * 4) + kPageControllerHeight) //视图总高度
@interface EmoticonInputView : UIView
{
    NSArray *_emoticonsArray;
    UIScrollView *_scrollView;
    UIPageControl *_countLable;
}

@end
