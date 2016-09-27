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
    UIColor *_textColor;
    
//    ThemeSeparator *sep;
}
@end
@implementation ThemeSeleteController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ksWidth, ksHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged) name:kThemePictureChange object:nil];
    
}
- (void)themeChanged
{
    _textColor = [[ThemeManager shareManager] colorWithName:kMoreItemTextColor];
    [_tableView reloadData];
    _tableView.separatorColor = [[ThemeManager shareManager] colorWithName:kMoreItemLineColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ThemeManager shareManager].allThemes.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeManager *manager = [ThemeManager shareManager];
    NSDictionary *allThemes = manager.allThemes;
    NSArray *allNames = allThemes.allKeys;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    

    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSString *key = allNames[indexPath.row];
    cell.textLabel.text = key;
    cell.textLabel.textColor = _textColor;
    
    NSString *imageName = [NSString stringWithFormat:@"%@/%@", allThemes[key], @"more_icon_theme.png"];
    UIImage *image = [UIImage imageNamed:imageName];
    cell.imageView.image = image;
    NSLog(@"111");
//    cell.colorName = @"bg_detail.jpg";
    
    if ([key isEqualToString:manager.nowThemeName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeManager *manager = [ThemeManager shareManager];
    NSDictionary *allThemes = manager.allThemes;
    NSArray *allNames = allThemes.allKeys;
    NSString *selectTheme = allNames[indexPath.row];

    manager.nowThemeName = selectTheme;
    [_tableView reloadData];
    
}

@end
