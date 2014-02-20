//
//  Content.h
//  Note
//
//  Created by 郭远强 on 14-1-28.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Content : NSManagedObject

@property (nonatomic, retain) NSString * tittle;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * createTime;

@end
