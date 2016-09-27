//
//  LocationViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/8/8.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#define kLocationNearbyAPI @"place/nearby/pois.json"
@interface LocationViewController () <CLLocationManagerDelegate, SinaWeiboRequestDelegate, UITableViewDataSource, UITableViewDelegate>
{
    CLLocationManager *_locationManager;
    NSArray *_locationArray;
    UITableView *_tableView;
}

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"周边地点";
    [self startLocation];
    [self createTableView];
}
- (void)startLocation
{
    _locationManager = [[CLLocationManager alloc] init];
    if (kSystemVersion >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//    NSLog(@"%@", locations);
    [manager stopUpdatingLocation];
    CLLocation *location = [locations firstObject];
    double lon = location.coordinate.longitude;
    double lat = location.coordinate.latitude;
    SinaWeibo *wb = kSinaWeiBoObject;
    NSDictionary *dic = @{@"long" : [NSString stringWithFormat:@"%f", lon],
                          @"lat" : [NSString stringWithFormat:@"%f", lat]};
    [wb requestWithURL:kLocationNearbyAPI params:[dic mutableCopy] httpMethod:@"GET" delegate:self];
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
//    NSLog(@"%@", result);
    _locationArray = result[@"pois"];
    [_tableView reloadData];
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ksWidth, ksHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _locationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *dic = _locationArray[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    if (![dic[@"address"] isKindOfClass:[NSNull class]]) {
        cell.detailTextLabel.text = dic[@"address"];
    }
    else
    {
        cell.detailTextLabel.text = nil;
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]]];
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_block) {
        _block(_locationArray[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addLocationResultBlock:(LocationResultBlock)block
{
    _block = [block copy];
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
