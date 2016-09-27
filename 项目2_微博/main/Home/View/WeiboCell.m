//
//  WeiboCell.m
//  项目2_微博
//
//  Created by mac57 on 16/8/2.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "WeiboCell.h"

#import "CellLayOut.h"
#import "WXLabel.h"
#import "WeiboWebViewController.h" 
#import "RegexKitLite.h"
#import "WXPhotoBrowser.h"  

@interface WeiboCell ()<WXLabelDelegate, PhotoBrowerDelegate>
{
    
}
@property (nonatomic , strong) WXLabel *weiboTextLable;
@property (nonatomic , strong) UIImageView *weiboImageView;

@property (nonatomic, strong) WXLabel *reWeiboTextLable;
@property (nonatomic, strong) ThemeImageView *reWeiboImageView;
@property (nonatomic, strong) ThemeImageView *reWeiboDetailView;
@property (nonatomic, strong) NSArray *imagesArray;
@end

@implementation WeiboCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    _mName.colorName = kHomeUserNameTextColor;
    _mSource.colorName = kHomeTimeLabelTextColor;
    _mTime.colorName = kHomeTimeLabelTextColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:kThemePictureChange object:nil];
    [self themeChange];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)themeChange {
    
//    ThemeManager *manager = [ThemeManager shareManage];
    ThemeManager *manager = [ThemeManager shareManager];
    
    self.weiboTextLable.textColor = [manager colorWithName:kHomeWeiboTextColor];
    self.reWeiboTextLable.textColor = [manager colorWithName:kHomeReWeiboTextColor];
    
}

-(void)setWeiboModel:(WeiboModel *)weiboModel
{
    _weiboModel = weiboModel;
    
    _mName.text = _weiboModel.user.name;
    [_mView sd_setImageWithURL:_weiboModel.user.profile_image_url];
//    NSLog(@"000%@", _mName.text);
    //来源
    if (_weiboModel.source.length != 0) {
        NSArray *array1 = [_weiboModel.source componentsSeparatedByString:@">"];
        NSString *string1 = [array1 objectAtIndex:1];
        NSArray *array2 = [string1 componentsSeparatedByString:@"<"];
        NSString *string2 = array2.firstObject;
        _mSource.text = [NSString stringWithFormat:@"来源:%@", string2];
        _mSource.hidden = NO;
        
    }else
    {
        _mSource.hidden = YES;
    }
    
    //时间
    //Tue Aug 02 15:40:49 +0800 2016
    NSString *time = @"E M d HH:mm:ss Z yyyy";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [dateFormat setDateFormat:time];
    NSDate *date = [dateFormat dateFromString:_weiboModel.created_at];
    NSTimeInterval dValue = -[date timeIntervalSinceNow];
    NSTimeInterval minite = dValue / 60;
    NSTimeInterval hour = minite / 60;
    NSTimeInterval day = hour / 24;
    NSString *timeStr = nil;
    if (dValue < 60) {
        timeStr = @"刚刚";
    }
    else if (minite < 60)
    {
        timeStr = [NSString stringWithFormat:@"%li分钟前", (NSInteger)minite];
    }
    else if (hour < 24)
    {
        timeStr = [NSString stringWithFormat:@"%li小时前", (NSInteger)hour];
    }
    else if (day < 7)
    {
        timeStr = [NSString stringWithFormat:@"%li天前", (NSInteger)day];
    }
    else
    {
        [dateFormat setDateFormat:@"M月d日 HH:mm"];
        [dateFormat setLocale:[NSLocale currentLocale]];
        timeStr = [dateFormat stringFromDate:date];
    }
    _mTime.text = timeStr;
    //正文
    CellLayOut *layout= [CellLayOut layoutWithWeibo:_weiboModel];

    
    
//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:_weiboModel.text];
//    NSString *range3 = @"(@[\\w-]{1,30})|(#[^#]+#)|(http(s)?://([a-zA-Z0-9._-]+(/)?)+)";
//    NSArray *array3 = [_weiboModel.text componentsMatchedByRegex:range3];
//    for (NSString *name in array3) {
//        NSLog(@"%@", name);
//        NSRange range = [_weiboModel.text rangeOfString:name];
//        //添加一条属性
//        //attribute NSString 需要添加的属性名
//        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
//    }
//        self.weiboTextLable.attributedText = attri;
    
    self.weiboTextLable.text = _weiboModel.text;
    self.weiboTextLable.frame = layout.weiboTextHeight;

    //图片
//    self.weiboImageView.frame = layout.weiboImageHeight;
//    [self.weiboImageView sd_setImageWithURL:_weiboModel.bmiddle_pic];
    if (_weiboModel.retweeted_status.bmiddle_pic) {
        for (UIImageView *iv in _imagesArray) {
            iv.frame = CGRectZero;
        }
//        for (int i = 0; i < 9; i++) {
//            UIImageView *iv = self.imagesArray[i];
//            NSValue *value = layout.imageFrameArray[i];
//            CGRect frame = [value CGRectValue];
//            iv.frame = frame;
//            if (i < _weiboModel.retweeted_status.pic_urls.count) {
//                NSURL *url = [NSURL URLWithString:_weiboModel.retweeted_status.pic_urls[i][@"bmiddle_pic"]];
//                [iv sd_setImageWithURL:url];
//            }
//        }
    }
    else if (_weiboModel.bmiddle_pic)
    {
        for (int i = 0; i < 9; i++) {
            UIImageView *iv = self.imagesArray[i];
            NSValue *value = layout.imageFrameArray[i];
            CGRect frame = [value CGRectValue];
            iv.frame = frame;
            if (i < _weiboModel.pic_urls.count) {
                NSURL *url = [NSURL URLWithString:_weiboModel.pic_urls[i][@"thumbnail_pic"]];
                [iv sd_setImageWithURL:url];
            }
        }
    }
    else
    {
        for (UIImageView *iv in _imagesArray) {
            iv.frame = CGRectZero;
        }
    }
    
    
    //转发微博
    /*
     NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:_weiboModel.text];
     NSString *range3 = @"(@[\\w-]{1,30})|(#[^#]+#)|(http(s)?://([a-zA-Z0-9._-]+(/)?)+)";
     NSArray *array3 = [_weiboModel.text componentsMatchedByRegex:range3];
     for (NSString *name in array3) {
     NSLog(@"%@", name);
     NSRange range = [_weiboModel.text rangeOfString:name];
     //添加一条属性
     //attribute NSString 需要添加的属性名
     [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
     }
     //    self.weiboTextLable.text = _weiboModel.text;.
     self.weiboTextLable.attributedText = attri;
     */
//    if (_weiboModel.retweeted_status.text == nil) {
//        self.reWeiboTextLable.text = _weiboModel.retweeted_status.text;
//    }
//    else{
//        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:_weiboModel.retweeted_status.text];
//        NSArray *array1 = [_weiboModel.retweeted_status.text componentsMatchedByRegex:range3];
//        for (NSString *name in array1) {
//            NSLog(@"%@", name);
//            NSRange range = [_weiboModel.retweeted_status.text rangeOfString:name];
//            //添加一条属性
//            //attribute NSString 需要添加的属性名
//            [attri1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
//        }
//        
//        self.reWeiboTextLable.attributedText = attri1;
//
//    }
    
    self.reWeiboTextLable.text = _weiboModel.retweeted_status.text;
    self.reWeiboTextLable.frame = layout.reWeiboTextFrame;
    //背景
    self.reWeiboImageView.frame = layout.reWeiboImageFrame;
    //转发微博的图片
//    self.reWeiboDetailView.frame = layout.reWeiboDetailView;
//    [self.reWeiboDetailView sd_setImageWithURL:_weiboModel.retweeted_status.bmiddle_pic];
}
- (WXLabel *)weiboTextLable
{
    if (_weiboTextLable == nil) {
        _weiboTextLable = [[WXLabel alloc] initWithFrame:CGRectZero];
        _weiboTextLable.font = kWeiboTextFont;
        _weiboTextLable.numberOfLines = 0;
        _weiboTextLable.wxLabelDelegate = self;
        _weiboTextLable.linespace = 3;
        [self.contentView addSubview:_weiboTextLable];
    }
    return _weiboTextLable;
}
//- (UIImageView *)weiboImageView
//{
//    if (_weiboImageView == nil) {
//        _weiboImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [self.contentView addSubview:_weiboImageView];
//    }
//    return _weiboImageView;
//}
-(WXLabel *)reWeiboTextLable{
    if (_reWeiboTextLable == nil) {
        _reWeiboTextLable = [[WXLabel alloc] initWithFrame:CGRectZero];
//        _reWeiboTextLable.colorName = kHomeReWeiboTextColor;
        _reWeiboTextLable.font = kReWeiboTextFont;
        _reWeiboTextLable.numberOfLines = 0;
        _reWeiboTextLable.wxLabelDelegate = self;
        _reWeiboTextLable.linespace = pointsize;
        [self.contentView addSubview:_reWeiboTextLable];
    }
    return _reWeiboTextLable;
}
- (ThemeImageView *)reWeiboImageView{
    if (_reWeiboImageView == nil) {
        _reWeiboImageView = [[ThemeImageView alloc] initWithFrame:CGRectZero];
        _reWeiboImageView.imageName = @"timeline_rt_border_selected_9.png";
        _reWeiboImageView.topCapHeight = 18;
        _reWeiboImageView.leftCapWidth = 30;
        [self.contentView insertSubview:_reWeiboImageView atIndex:0];
    }
    return _reWeiboImageView;
}
//- (ThemeImageView *)reWeiboDetailView{
//    if (_reWeiboDetailView == nil) {
//        _reWeiboDetailView = [[ThemeImageView alloc] initWithFrame:CGRectZero];
//        [self.contentView addSubview:_reWeiboDetailView];
//    }
//    return _reWeiboDetailView;
//}
-(NSArray *)imagesArray{
    if (_imagesArray == nil) {
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9 ; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:imageView];
            [mArray addObject:imageView];
            imageView.backgroundColor = [UIColor orangeColor];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewAction:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:tap];
            
            //开启图片视图的用户事件
            imageView.userInteractionEnabled = YES;
            
            imageView.tag = i;
        }
        _imagesArray = [mArray copy];
    }
    return _imagesArray;
}
//检索文本的正则表达式的字符串

- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@[\\w-]{2,30}";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#[^#]+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}
//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
    
    return [[ThemeManager shareManager] colorWithName:kLinkColor];
    
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel {
    
    return [UIColor redColor];
}
- (void)toucheEndWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context
{
    NSString *regex = @"http(s)?://([a-zA-Z0-9.-_]+(/)?)+";
    if ([context isMatchedByRegex:regex]) {
        WeiboWebViewController *webVC = [[WeiboWebViewController alloc] initWithURL:[NSURL URLWithString:context]];
        
        UIResponder *nextResponder = self.nextResponder;
        while (nextResponder) {
            if ([nextResponder isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navi = (UINavigationController *)nextResponder;
                [navi pushViewController:webVC animated:YES];
                break;
            }
            nextResponder = nextResponder.nextResponder;
        }
        
    }
}
- (void)tapImageViewAction:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    [WXPhotoBrowser showImageInView:self.window selectImageIndex:imageView.tag delegate:self];
}
//需要显示的图片个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(WXPhotoBrowser *)photoBrowser
{
    if (_weiboModel.retweeted_status.pic_urls.count > 0) {
        return _weiboModel.retweeted_status.pic_urls.count;
    }
    else
    {
        return _weiboModel.pic_urls.count;
    }
}

//返回需要显示的图片对应的Photo实例,通过Photo类指定大图的URL,以及原始的图片视图
- (WXPhoto *)photoBrowser:(WXPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    WXPhoto *photo = [[WXPhoto alloc] init];
    NSString *imageUrlString = nil;
    if (_weiboModel.retweeted_status.pic_urls.count > 0) {
        NSDictionary *dic = _weiboModel.retweeted_status.pic_urls[index];
        imageUrlString = dic[@"thumbnail_pic"];
    }
    else
    {
        NSDictionary *dic = _weiboModel.pic_urls[index];
        imageUrlString = dic[@"thumbnail_pic"];
    }
    imageUrlString = [imageUrlString stringByReplacingOccurrencesOfRegex:@"thumbnail" withString:@"large"];
    photo.url = [NSURL URLWithString:imageUrlString];
    photo.srcImageView = _imagesArray[index];
    return photo;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
