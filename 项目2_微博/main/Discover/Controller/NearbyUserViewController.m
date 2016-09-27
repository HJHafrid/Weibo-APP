//
//  NearbyUserViewController.m
//  项目2_微博
//
//  Created by mac57 on 16/8/9.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "NearbyUserViewController.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "YYModel.h"
#import <CoreLocation/CoreLocation.h>
#import "Weiboannotation.h"
#import "WeiboAnnotationView.h"
#define kNearbyWeiboAPI @"place/nearby_timeline.json"
@interface NearbyUserViewController ()<MKMapViewDelegate, SinaWeiboRequestDelegate>
{
    MKMapView *_mapView;
    BOOL _isLocaion;
}

@end
@implementation NearbyUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isLocaion = NO;
    [self createMapView];
}
- (void)createMapView
{
    if (kSystemVersion > 8.0) {
        [[[CLLocationManager alloc] init] requestAlwaysAuthorization];
    }
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    NSLog(@"%@", userLocation);
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    double lat = coordinate.latitude;
    double lon = coordinate.longitude;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region animated:YES];
    if (_isLocaion == NO) {
        _isLocaion = YES;
        SinaWeibo *wb = kSinaWeiBoObject;
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:[NSString stringWithFormat:@"%f", lat] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", lon] forKey:@"long"];
        [wb requestWithURL:kNearbyWeiboAPI params:params httpMethod:@"GET" delegate:self];
    }
}
-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *array = result[@"statuses"];
    for (NSDictionary *dic in array) {
        WeiboModel *model = [WeiboModel yy_modelWithJSON:dic];
        Weiboannotation *annotation = [[Weiboannotation alloc] init];
        annotation.weiboModel = model;
        
        //在地图中添加标注点
        [_mapView addAnnotation:annotation];
    }
}
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    WeiboAnnotationView *view = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"WeiboAnnotation"];
    if (view == nil) {
        view = [[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"WeiboAnnotation"];
    }
    return view;
}
@end
