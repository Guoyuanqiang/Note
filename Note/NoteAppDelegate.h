//
//  NoteAppDelegate.h
//  Note
//
//  Created by 郭远强 on 14-1-23.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NoteAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//数据模型对象
@property (strong, nonatomic) NSManagedObjectModel *manageModel;
//上下文对象
@property (strong, nonatomic) NSManagedObjectContext *manageContext;
//持久性存储区
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentCoordinator;

//初始化持久性存储区
-(NSPersistentStoreCoordinator *)persistentCoordinator;
//manageContext的初始化赋值函数
-(NSManagedObjectContext *)manageContext;
//manageModel的初始化赋值函数
-(NSManagedObjectModel *)manageModel;

@end
