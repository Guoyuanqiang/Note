//
//  NotePageViewController.h
//  Note
//
//  Created by 郭远强 on 14-1-23.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotePageViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *contentDatasource;
    NSMutableArray *timeDtaSource;
}
@property (retain, nonatomic) NSMutableArray *contentDatasource;
@property (weak, nonatomic) NSMutableArray *timeDataSource;
-(NSMutableArray *)fetchRequestResult;
- (void)deleteRowData:(NSInteger)row;
@end
