//
//  NoteAddContentViewController.h
//  Note
//
//  Created by 郭远强 on 14-2-4.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteAppDelegate.h"

@interface NoteAddContentViewController : UIViewController<UITextFieldDelegate>
{
    UIView *childView;
    int pageCount;
}
@property (strong, nonatomic) NoteAppDelegate *myContentDelegate;
@property (nonatomic) NSInteger Contentrow;
@end
