//
//  EmoticonView.m
//  项目2_微博
//
//  Created by mac57 on 16/8/10.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "EmoticonView.h"
#import "EmoticonInputView.h"
#import "Emoticon.h"    
@implementation EmoticonView
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
//        lable.text = @"123123123123";
//        [self addSubview:lable];
//    }
//    return self;
//}
- (void)drawRect:(CGRect)rect
{
    if (_emoticonsArray == nil || _emoticonsArray.count == 0) {
        return;
    }
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 8; j++) {
            NSInteger index = i * 8 + j;
            if (index >= _emoticonsArray.count) {
                return;
            }
            CGRect rect = CGRectMake(j * kEmoticonWidth + 6, i * kEmoticonWidth + 6, kEmoticonWidth - 12, kEmoticonWidth - 12);
            Emoticon *emoticon = _emoticonsArray[index];
            UIImage *image = [emoticon emoticonImage];
            [image drawInRect:rect];
        }
    }
}
-(void)setEmoticonsArray:(NSArray *)emoticonsArray
{
    if (_emoticonsArray != emoticonsArray && emoticonsArray.count > 0 && emoticonsArray.count <= 32) {
        _emoticonsArray = [emoticonsArray copy];
        [self setNeedsDisplay];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    int i = point.y / kEmoticonWidth;
    int j = point.x / kEmoticonWidth;
    NSInteger index = i * 8 + j;
    if (index < _emoticonsArray.count) {
        Emoticon *e = _emoticonsArray[index];
        NSLog(@"%@", e.chs);
    }
}

@end
