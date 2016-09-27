

//
//  CellLayOut.m
//  项目2_微博
//
//  Created by mac57 on 16/8/3.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "CellLayOut.h"
#import "WXLabel.h"
@interface CellLayOut()
{
    CGFloat _cellHeight;
}
@end
@implementation CellLayOut
+(instancetype)layoutWithWeibo:(WeiboModel *)weibo
{
    CellLayOut *LayOut = [[CellLayOut alloc] init];
    if (LayOut) {
        LayOut.weibo = weibo;
    }
    return LayOut;
}
-(void)setWeibo:(WeiboModel *)weibo
{
    if (_weibo == weibo) {
        return;
    }
    _weibo = weibo;
    _cellHeight = 0;
    _cellHeight += cellRowHeight;
    _cellHeight += spaceWidth;
    NSDictionary *attributes = @{NSFontAttributeName : kWeiboTextFont};
    
//    CGRect rect = [_weibo.text boundingRectWithSize:CGSizeMake(ksWidth - 20, 1000)
//                                        options:NSStringDrawingUsesLineFragmentOrigin
//                                     attributes:attributes
//                                        context:nil];
//    CGFloat weiboTextHeight = rect.size.height;
    CGFloat weiboTextHeight = [WXLabel getTextHeight:kWeiboTextFont.pointSize width:ksWidth - 20 text:_weibo.text linespace:pointsize];

    _weiboTextHeight = CGRectMake(spaceWidth, cellRowHeight + spaceWidth, ksWidth - 2 * spaceWidth, weiboTextHeight);
    _cellHeight += weiboTextHeight;
    _cellHeight += spaceWidth;
    
//    if (_weibo.bmiddle_pic) {
//        _weiboImageHeight = CGRectMake(spaceWidth, _cellHeight, cellImageView, cellImageView);
//        _cellHeight += cellImageView;
//        _cellHeight += spaceWidth;
//    }
//    else
//    {
//        _weiboImageHeight = CGRectZero;
//    }
    
    if (_weibo.retweeted_status) {
        attributes = @{NSFontAttributeName : kReWeiboTextFont};
//        CGRect rect = [_weibo.retweeted_status.text boundingRectWithSize:CGSizeMake(ksWidth - 4 * spaceWidth, 1000)
//                                                          options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        CGFloat reWeiboTectHeight = [WXLabel getTextHeight:kReWeiboTextFont.pointSize width:ksWidth - 4 * spaceWidth text:_weibo.retweeted_status.text linespace:pointsize];
        reWeiboTectHeight += 2;
        _reWeiboTextFrame = CGRectMake(2 * spaceWidth, _cellHeight + 10, ksWidth - 4 * spaceWidth, reWeiboTectHeight);
        _cellHeight += reWeiboTectHeight;
        _cellHeight += spaceWidth * 2;
        
        _reWeiboImageFrame = CGRectMake(spaceWidth, _reWeiboTextFrame.origin.y - spaceWidth, ksWidth - 2 * spaceWidth, 2 * spaceWidth + _reWeiboTextFrame.size.height);
        _cellHeight += spaceWidth;
    }
    else
    {
        _reWeiboTextFrame = CGRectZero;
        _reWeiboImageFrame = CGRectZero;
        
        if (_weibo.pic_urls.count > 0) {
            CGFloat imageHeight = [self LayoutNineImageViewWithImageCount:_weibo.pic_urls.count viewWidth:(ksWidth - 2 * spaceWidth) top:(CGRectGetMaxY(_weiboTextHeight) + spaceWidth)];
            _cellHeight += imageHeight;
            _cellHeight += spaceWidth;
        }
        else
        {
            _imageFrameArray = nil;
        }
    }
//    if (_weibo.retweeted_status.bmiddle_pic) {
//        _reWeiboDetailView = CGRectMake(2 * spaceWidth, CGRectGetMaxY(_reWeiboTextFrame) + spaceWidth, cellImageView, cellImageView);
//        _cellHeight += _reWeiboDetailView.size.height;
//        _cellHeight += spaceWidth * 2;
//        _reWeiboImageFrame.size.height += _reWeiboDetailView.size.height + spaceWidth;
//    }
//    else
//    {
//        _reWeiboDetailView = CGRectZero;
//    }
}
-(CGFloat)LayoutNineImageViewWithImageCount:(NSInteger)imageCount
                                 viewWidth:(CGFloat)viewWidth
                                        top:(CGFloat)top
{
    if (imageCount > 9 || imageCount <= 0) {
        _imageFrameArray  = nil;
        return 0;
    }
    CGFloat viewHeight;
    CGFloat imageWidth;
    NSInteger numberOfColumn = 2;
    if (imageCount == 1) {
        numberOfColumn = 1;
        imageWidth = viewWidth;
        viewHeight = viewWidth;
    }
    else if (imageCount == 2){
        imageWidth = (viewWidth - ImageViewSpace) / 2;
        viewHeight = imageWidth;
    }
    else if (imageCount == 4){
        imageWidth = (viewWidth - ImageViewSpace) / 2;
        viewHeight = viewWidth;
        
    }else{
        imageWidth = (viewWidth - 2 * ImageViewSpace) / 3;
        numberOfColumn = 3;
        if (imageCount == 3) {
            viewHeight = imageWidth;
        }
        else if (imageCount <= 6){
            viewHeight = imageWidth * 2 + ImageViewSpace;
        }
        else
        {
            viewHeight = viewWidth;
        }
    }
    NSMutableArray *marray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        if (i >= imageCount) {
            CGRect frame = CGRectZero;
            [marray addObject:[NSValue valueWithCGRect:frame]];
        }
        else
        {
            NSInteger row = i / numberOfColumn;
            NSInteger colume = i % numberOfColumn;
            CGFloat width = imageWidth + ImageViewSpace;
            CGFloat left = (ksWidth - viewWidth) / 2;
            CGRect frame =CGRectMake(colume * width + left, row * width + top, imageWidth, imageWidth);
            [marray addObject:[NSValue valueWithCGRect:frame]];
        }
    }
    _imageFrameArray = [marray copy];
    return viewHeight;
}





- (CGFloat)cellHeight
{
    return _cellHeight;
}
@end
