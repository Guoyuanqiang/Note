//
//  NoteContentViewController.h
//  Note
//
//  Created by 郭远强 on 14-1-23.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteAppDelegate.h"

@interface NoteContentViewController : UIViewController<UITextViewDelegate>{
    NSString *textString;
    UIView *childView;
}
@property (retain, nonatomic) NSString *textString;
@property (strong, nonatomic) NoteAppDelegate *myDelegate;
@property (weak, nonatomic) NSString *Vtext;
@property (weak, nonatomic) NSString *nonVtext;
@property (nonatomic) NSInteger Contentrow;
- (void)Query;
@end
