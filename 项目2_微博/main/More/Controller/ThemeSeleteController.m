//
//  ThemeSeleteController.m
//  项目2_微博
//
//  Created by 黄家辉 on 16/7/31.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "ThemeSeleteController.h"
@interface ThemeSeleteController ()<UITableViewDelegate , UITableViewDataSource>
{
    UITableView *_tableView;
    
    
    
    
    
}
@end
@implementation ThemeSeleteController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ksWidth, ksHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ThemeManager shareManager].allThemes.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeManager *manager = [ThemeManager shareManager];
    NSDictionary *themesName = manager.allThemes;
    NSArray *themeName = themesName.allKeys;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *name = themeName[indexPath.row];
    cell.textLabel.text = name;
    
    NSString *picName = [NSString stringWithFormat:@"%@/%@", themesName[name], @"more_icon_theme.png"];
    UIImage *image = [UIImage imageNamed:picName];
    cell.imageView.image = image;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    [cell addGestureRecognizer:tap];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%li", indexPath.row);
    ThemeManager *manager = [ThemeManager shareManager];
    NSDictionary *themesName = manager.allThemes;
    NSArray *themeName = themesName.allKeys;
    NSString *name = themeName[indexPath.row];
    NSMutableString *picName = [NSMutableString stringWithFormat:@"%@", themesName[name]];
    NSRange range = NSMakeRange(0, 6);
    [picName deleteCharactersInRange:range];
    NSLog(@"%@", picName);
    [ThemeManager shareManager].nowThemeName = picName;
    
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"1");
    
    
}
@end
