//
//  HomeViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/7/29.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ThemeImageView.h"
#import "YYModel.h" 
#import "WeiboModel.h"
#import "UserModel.h"
#import "WeiboCell.h"
#import "CellLayOut.h"
#import "WXRefresh.h"
#import <AVFoundation/AVFoundation.h>
#define kGetTimeLineWeiboAPI @"statuses/home_timeline.json"

@interface HomeViewController ()<SinaWeiboRequestDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_weiboArray;
    ThemeImageView *_newWeiboCountView;
    UILabel *_newWeiboCountLabel;
    SystemSoundID _msgComeID;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTableView];
    [self loadWeiboData];
//    [self loadMoreData];
    
    //获取声音文件路径 NSURL
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"msgcome" withExtension:@"wav"];
    //注册系统声音
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &_msgComeID);
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //注销系统声音
    AudioServicesRemoveSystemSoundCompletion(_msgComeID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadWeiboData
{
    SinaWeibo *weibo = kSinaWeiBoObject;
    if (![weibo isAuthValid]) {
        [weibo logIn];
        return;
    }
    NSDictionary *params = @{@"count" : @"20"};
    SinaWeiboRequest *request = [weibo requestWithURL:kGetTimeLineWeiboAPI params:[params mutableCopy] httpMethod:@"GET" delegate:self];
    request.tag = 0;
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSMutableArray *marray = [[NSMutableArray alloc] init];
    NSArray *array = result[@"statuses"];
    
//    NSLog(@"result = %@", result);
    for (NSDictionary *dic in array) {
        WeiboModel *Weibo = [WeiboModel yy_modelWithJSON:dic];
        [marray addObject:Weibo];
    }
    
    if (request.tag == 0) {
        _weiboArray = [marray mutableCopy];
    }
    else if (request.tag == 1)
    {
        if (marray.count == 0) {
            [_tableView.pullToRefreshView stopAnimating];
            [self showNewWeiboCount:0];
            return;
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, marray.count)];
        [_weiboArray insertObjects:marray atIndexes:indexSet];
        [_tableView.pullToRefreshView stopAnimating];
        [self showNewWeiboCount:marray.count];
    }
    else if(request.tag == 2)
    {
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(marray.count , marray.count)];
//        [_weiboArray insertObjects:marray atIndexes:indexSet];
        [_weiboArray addObjectsFromArray:marray];
        [_tableView.infiniteScrollingView stopAnimating];
    }
    
    
    [_tableView reloadData];
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ksWidth, ksHeight - 49 -64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"WeiboCell"];
    
    __weak HomeViewController *weakSelf = self;
    [_tableView addPullDownRefreshBlock:^{
        __strong HomeViewController *strongSelf = weakSelf;
        [strongSelf loadNewData];
    }];
    [_tableView addInfiniteScrollingWithActionHandler:^{
        __strong HomeViewController *strongSelf = weakSelf;
        [strongSelf loadMoreData];
    }];
    
    //创建新微博提示视图
    _newWeiboCountView = [[ThemeImageView alloc] initWithFrame:CGRectMake(3, 64+3, ksWidth - 6, 40)];
    _newWeiboCountView.imageName = @"timeline_notify.png";
    _newWeiboCountView.transform = CGAffineTransformMakeTranslation(0, -60);
    [self.view addSubview:_newWeiboCountView];
    
    //文本显示Label
    _newWeiboCountLabel = [[UILabel alloc] initWithFrame:_newWeiboCountView.bounds];
    [_newWeiboCountView addSubview:_newWeiboCountLabel];
    _newWeiboCountLabel.textAlignment = NSTextAlignmentCenter;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _weiboArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCell"];
    
    WeiboModel *wb = _weiboArray[indexPath.row];
//    UserModel *user = wb.user;
//    cell.textLabel.text = user.name;
//    cell.detailTextLabel.text = wb.text;
    [cell setWeiboModel:wb];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboModel *wb = _weiboArray[indexPath.row];

    CellLayOut *layout = [CellLayOut layoutWithWeibo:wb];
    return [layout cellHeight];
}
- (void)loadNewData
{
    WeiboModel *firstModel = [_weiboArray firstObject];
    NSString *idstr = firstModel.idstr;
    SinaWeibo *weibo = kSinaWeiBoObject;
    if (![weibo isAuthValid]) {
        [weibo logIn];
        return;
    }
    NSDictionary *params = @{@"count" : @"20",
                             @"since_id" : idstr};
    SinaWeiboRequest *request = [weibo requestWithURL:kGetTimeLineWeiboAPI params:[params mutableCopy] httpMethod:@"GET" delegate:self];
    request.tag = 1;
}
- (void)loadMoreData
{
//    [_tableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
    WeiboModel *lastWeibo = [_weiboArray lastObject];
    NSString *idstr = lastWeibo.idstr;
    
    SinaWeibo *weibo = kSinaWeiBoObject;
    if (![weibo isAuthValid]) {
        [weibo logIn];
        return;
    }
    NSDictionary *params = @{@"count" : @"20",
                             @"max_id" : idstr};
    SinaWeiboRequest *request = [weibo requestWithURL:kGetTimeLineWeiboAPI params:[params mutableCopy] httpMethod:@"GET" delegate:self];
    request.tag = 2;
}
- (void)showNewWeiboCount:(NSInteger)count {
    
    //设置文本显示的条数
    if (count == 0) {
        _newWeiboCountLabel.text = @"没有新微博";
    } else {
        _newWeiboCountLabel.text = [NSString stringWithFormat:@"%li条新微博", count];
    }
    
    //播放动画效果
    [UIView animateWithDuration:0.5 animations:^{
        _newWeiboCountView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //播放提示音
        AudioServicesPlaySystemSound(_msgComeID);
        //延迟两秒，再次动画
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _newWeiboCountView.transform = CGAffineTransformMakeTranslation(0, -60);
        } completion:nil];
    }];
}
- (void)reloadNewWeibo
{
    [_tableView.pullToRefreshView startAnimating];
    [self loadNewData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
