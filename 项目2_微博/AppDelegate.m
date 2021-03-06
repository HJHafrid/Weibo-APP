//
//  AppDelegate.m
//  项目2_微博
//
//  Created by mac57 on 16/7/29.
//  Copyright © 2016年 mac57. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "BaseNavigationController.h"
#define kWeiboAuthDateKey @"kWeiboAuthDateKey"
@interface AppDelegate ()<SinaWeiboDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    MainTabBarController *tab = [[MainTabBarController alloc] init];
//    self.window.rootViewController = tab;
    
    LeftViewController *leftvc = [[LeftViewController alloc] init];
    RightViewController *rightvc = [[RightViewController alloc] init];
    BaseNavigationController *leftCtrl = [[BaseNavigationController alloc] initWithRootViewController:leftvc];
    BaseNavigationController *rightCtrl = [[BaseNavigationController alloc] initWithRootViewController:rightvc];
    MMDrawerController *mmd = [[MMDrawerController alloc] initWithCenterViewController:tab leftDrawerViewController:leftCtrl rightDrawerViewController:rightCtrl];
    mmd.maximumLeftDrawerWidth = 180;
    mmd.maximumRightDrawerWidth = 80;
    [mmd setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmd setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [mmd setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMExampleDrawerVisualStateManager *manager = [MMExampleDrawerVisualStateManager sharedManager];
        MMDrawerControllerDrawerVisualStateBlock block = [manager drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    
    self.window.rootViewController = mmd;
    
    _sinaWeibo = [[SinaWeibo alloc] initWithAppKey:@"1328979684" appSecret:@"3866fbc92658b2cbd179cc7f9984b2f2" appRedirectURI:@"http://www.baidu.com" andDelegate:self];
    
    BOOL isAuth = [self readAuthData];
    if (isAuth == NO) {
        [self.sinaWeibo logIn];
        NSLog(@"从未登录过微博， 需要重新登录");
    }
    else{
        NSLog(@"已登录微博:%@", self.sinaWeibo.accessToken);
    }
    
    return YES;
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"登录成功:%@", sinaweibo.accessToken);
    [self saveAuthData];
    NSLog(@"%@", NSHomeDirectory());
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"登出");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWeiboAuthDateKey];
}
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    [self.sinaWeibo logOut];
//    [NSUserDefaults standardUserDefaults];
}
- (void)logoutWeibo
{
    [_sinaWeibo logOut];
}
- (void)saveAuthData
{
    NSString *token = _sinaWeibo.accessToken;
    NSString *userId = _sinaWeibo.userID;
    NSDate *date = _sinaWeibo.expirationDate;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = @{@"accessToken" : token,
                          @"uid" : userId,
                          @"expirationDate" : date};
    [userDef setObject:dic forKey:kWeiboAuthDateKey];
    [userDef synchronize];
}
- (BOOL)readAuthData
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDef objectForKey:kWeiboAuthDateKey];
    if (dic == nil) {
        return NO;
    }
    NSString *token = dic[@"accessToken"];
    NSString *userId = dic[@"uid"];
    NSDate *date = dic[@"expirationDate"];
    
    if (token == nil || userId == nil || date == nil) {
        return NO;
    }
    _sinaWeibo.accessToken = token;
    _sinaWeibo.userID = userId;
    _sinaWeibo.expirationDate = date;
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "-23456.__2___" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"__2___" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"__2___.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
