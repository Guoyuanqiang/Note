//
//  NoteViewController.h
//  Note
//
//  Created by 郭远强 on 14-1-23.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray *data;
}
@property (retain,nonatomic) NSArray *data;
@end
