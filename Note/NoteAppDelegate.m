//
//  NoteAppDelegate.m
//  Note
//
//  Created by 郭远强 on 14-1-23.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import "NoteAppDelegate.h"

@implementation NoteAppDelegate

-(NSPersistentStoreCoordinator *)persistentCoordinator
{
    if (nil != _persistentCoordinator) {
        return _persistentCoordinator;
    }
    //得到数据库路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    //CoreData是建立在SQLite之上的，所以数据库名称需要与Xcdatamodel文件同名
    NSURL *storeURL = [NSURL fileURLWithPath:[docs stringByAppendingString:@"Model.sqlite"]];
    NSError *error = nil;
    _persistentCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self manageModel]];
    
    if (![_persistentCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"error: %@, %@",error, [error userInfo]);
    }
    return self.persistentCoordinator;
}

-(NSManagedObjectModel *)manageModel
{
    if (nil != _manageModel) {
        return _manageModel;
    }
    _manageModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _manageModel;
}

-(NSManagedObjectContext *)manageContext
{
    if (nil != _manageContext) {
        return _manageContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentCoordinator];
    if (nil != coordinator) {
        _manageContext = [[NSManagedObjectContext alloc] init];
        [_manageContext setPersistentStoreCoordinator:coordinator];
    }
    return _manageContext;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSLog(@"------Test");
    NSLog(@"------Test1");
    NSLog(@"------Test2");
    NSLog(@"------Test3");
    NSLog(@"------Test4");
    NSLog(@"------Test5");
    NSLog(@"------Test6");
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSError *error;
    if (nil != self.manageContext) {
        if ([self.manageContext hasChanges] && ![self.manageContext save:&error]) {
            NSLog(@"error:%@,%@",error,[error userInfo]);
            abort();
        }
    }
}

@end
