//
//  ProfileViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/7/29.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "ThemeImageView.h"
#import "YYModel.h"
#import "WeiboModel.h"
#import "UserModel.h"
#import "WeiboCell.h"
#import "cellLayout.h"
#define kGetTimeLineWeiboAPI1 @"users/show.json"
#define kGetTimeLineWeiboAPI @"statuses/user_timeline.json"
@interface ProfileViewController ()<SinaWeiboRequestDelegate,UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_weiboArray;
}
@property (weak, nonatomic) IBOutlet ThemeLable *fensi;
@property (weak, nonatomic) IBOutlet ThemeLable *guanzhu;
@property (weak, nonatomic) IBOutlet ThemeLable *allMessage;
@property (weak, nonatomic) IBOutlet ThemeLable *heheText;
@property (weak, nonatomic) IBOutlet ThemeLable *threeMessage;
@property (weak, nonatomic) IBOutlet ThemeLable *myNameText;
@property (weak, nonatomic) IBOutlet UIImageView *myHeadImage;
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadWeiboData1];
//    [self loadWeiboData1]; 
//    self.view.backgroundColor = [UIColor purpleColor];
    [self createTableView];

    _tableView.tableHeaderView = _headView;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, ksWidth, ksHeight - 59) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];

    [self.view addSubview:_tableView];
    
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"WeiboCell"];
}
-(void)loadWeiboData1
{
    SinaWeibo *weibo1 = kSinaWeiBoObject;
    if (![weibo1 isAuthValid]) {
        [weibo1 logIn];
        return;
    }
    //NSDictionary *params1 = @{@"uid" : weibo1.userID};
    [weibo1 requestWithURL:kGetTimeLineWeiboAPI params:nil
                httpMethod:@"GET" delegate:self];
}

-(void)loadWeiboData
{

    
    SinaWeibo *weibo = kSinaWeiBoObject;
    if (![weibo isAuthValid]) {
        [weibo logIn];
        return;
    }
//    NSDictionary *params = @{@"count" : @"80"};
    [weibo requestWithURL:kGetTimeLineWeiboAPI params:nil httpMethod:@"GET" delegate:self];
    

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    //NSLog(@"!!!!result = %@", result);
    _marray = [[NSArray alloc] init];
    NSDictionary *dic = [[NSDictionary alloc] init];
    dic = result;
    _marray = dic[@"statuses"];
    NSDictionary *mDic = _marray[0];
    WeiboModel *my = [WeiboModel yy_modelWithJSON:mDic];
    //设置属性
    _fensi.text = my.user.followers_count;
    _guanzhu.text = my.user.friends_count;
//    _allMessage.text = my.user.MYdescription;
//    _threeMessage.text = my.user.gender;
    _allMessage.text = [NSString stringWithFormat:@"共%@条微博数", my.user.statuses_count];
    _heheText.text = my.user.MYdescription;
    _myNameText.text = my.user.screen_name;
    [_myHeadImage sd_setImageWithURL:my.user.profile_image_url];
    NSString *username;
    if ([my.user.gender isEqualToString:@"m"]) {
        username = @"男";
    }
    else if([my.user.gender isEqualToString:@"n"])
    {
        username = @"女";
    }
    else
    {
        username = @"未知";
    }
    _threeMessage.text = [NSString stringWithFormat:@"%@ %@", username, my.user.location];
//    NSLog(@"%@!!!",my.user.gender);
    UIColor *_textColor = [[ThemeManager shareManager] colorWithName:kMoreItemTextColor];
    
    _fensi.textColor = _textColor;
    _guanzhu.textColor = _textColor;
    _allMessage.textColor = _textColor;
    _threeMessage.textColor = _textColor;
    _myNameText.textColor = _textColor;
    
    NSMutableArray *marray = [[NSMutableArray alloc] init];
    NSArray *array = result[@"statuses"];
    for (NSDictionary *dic in array) {
        WeiboModel *Weibo = [WeiboModel yy_modelWithJSON:dic];
        [marray addObject:Weibo];
    }
    _weiboArray = [marray mutableCopy];
    [_tableView reloadData];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *name = @"Header ID";
//    UITableViewHeaderFooterView *mheadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:name];
//    if (mheadView == nil) {
//        mheadView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:name];
//        [mheadView addSubview:_headView];
//    }
//    return mheadView;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _weiboArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCell"];
//    if (cell == nil) {
//        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WeiboCell"];
//    }
//    return cell;
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCell"];
    
    WeiboModel *wb = _weiboArray[indexPath.row];
    [cell setWeiboModel:wb];
    return cell;

}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 188;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboModel *wb = _weiboArray[indexPath.row];
    
    CellLayOut *layout = [CellLayOut layoutWithWeibo:wb];
    return [layout cellHeight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
