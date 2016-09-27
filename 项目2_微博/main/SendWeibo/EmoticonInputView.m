//
//  EmoticonInputView.m
//  项目2_微博
//
//  Created by mac57 on 16/8/10.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "EmoticonInputView.h"
#import "YYModel.h"
#import "Emoticon.h"
#import "EmoticonView.h"    
@implementation EmoticonInputView
-(instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = kEmoticonInputViewHeight;
    frame.origin = CGPointZero;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self loadData];
        [self createScrollView];
    }
    return self;
}
- (void)loadData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        Emoticon *e =[Emoticon yy_modelWithJSON:dic];
        [mArray addObject:e];
    }
    _emoticonsArray = [mArray copy];
}
- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ksWidth, kScrollViewHeight)];
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(ksWidth * 4, _scrollView.bounds.size.height);
    _scrollView.pagingEnabled = YES;
//    _scrollView.showsHorizontalScrollIndicator = YES;
//    _scrollView.showsVerticalScrollIndicator = NO;
    NSInteger pageCount = (_emoticonsArray.count - 1) / 32 + 1;
    for (int i = 0 ; i < pageCount; i++) {
        EmoticonView *emoticonView = [[EmoticonView alloc] initWithFrame:CGRectMake(i * ksWidth, 0, ksWidth, kScreenHeight)];
        NSRange range = NSMakeRange(i * 32, 32);
        if (range.location + range.length > _emoticonsArray.count) {
            range.length = _emoticonsArray.count - range.location;
        }
        NSArray *subarray = [_emoticonsArray subarrayWithRange:range];
        emoticonView.emoticonsArray = subarray;
        [_scrollView addSubview:emoticonView];
    }
    _scrollView.contentSize = CGSizeMake(pageCount * ksWidth, 0);
    //lable
    _countLable = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kEmoticonInputViewHeight - kPageControllerHeight, ksWidth, kPageControllerHeight)];
    _countLable.backgroundColor = [UIColor blackColor];
    _countLable.numberOfPages = 4;
    [self addSubview:_countLable];
    [_countLable addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
}
- (void)action
{
    float x = _countLable.currentPage * ksWidth;
    _scrollView.contentOffset = CGPointMake(x, 0);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = (int) scrollView.contentOffset.x / ksWidth;
    _countLable.currentPage = index;
}
@end
