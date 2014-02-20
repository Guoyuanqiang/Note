//
//  NoteContentViewController.m
//  Note
//
//  Created by 郭远强 on 14-1-23.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import "NoteContentViewController.h"
#import "Content.h"
#import "NoteAppDelegate.h"
#import "NotePageViewController.h"
#import "NoteAddContentViewController.h"

@interface NoteContentViewController ()

@property (weak, nonatomic) IBOutlet UITextView *TextViewField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *BnavigationItem;

@property (weak, nonatomic) NSMutableArray *entities;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *TapGesture;
@property (weak, nonatomic) IBOutlet UIToolbar *funcToolBar;
@end

@implementation NoteContentViewController
@synthesize textString;
@synthesize Contentrow;

- (IBAction)AddContent:(UIBarButtonItem *)sender {
            NoteAddContentViewController *notePageView = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteAddContent"];
            [self.navigationController pushViewController:notePageView animated:YES];
//            NSLog(@"segue");
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
    
}
- (IBAction)DeleteContent:(UIBarButtonItem *)sender {
    [self.TapGesture setNumberOfTouchesRequired:1];
    [self.view setAlpha:0.8];
    CGRect viewRect = CGRectMake(0.0, 380, 320, 100);
    CGRect deleteButtonRect = CGRectMake(4.0, 0.0, 312, 46);
    CGRect cancleButtonRect = CGRectMake(4.0, 50, 312, 46);
    childView = [[UIView alloc] initWithFrame:viewRect];
    childView.backgroundColor = [UIColor whiteColor];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteButton.frame = deleteButtonRect;
    cancleButton.frame = cancleButtonRect;
    
    deleteButton.layer.cornerRadius = 10.0;
    cancleButton.layer.cornerRadius = 10.0;
    
    deleteButton.showsTouchWhenHighlighted = YES;
    cancleButton.showsTouchWhenHighlighted = YES;
    
    
    //deleteButton.layer.borderWidth = 1.0;
    
    [deleteButton setTitle:@"Delete Note" forState:UIControlStateNormal];
    [cancleButton setTitle:@"Cancle" forState:UIControlStateNormal];
    
    
    
	UIColor *color1 = [UIColor colorWithRed:1 green:0 blue:0 alpha:1.0];
	
	UIColor *color2 = [UIColor colorWithRed:0.392 green:0.584 blue:0.929 alpha:1.0];
	
	UIColor *color3 = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    
	deleteButton.tintColor = color1;
    cancleButton.tintColor = color2;
    
    deleteButton.backgroundColor = color3;
    cancleButton.backgroundColor = color3;
    
    [deleteButton addTarget:self action:@selector(deleteco) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:childView];
    [childView addSubview:deleteButton];
    [childView addSubview:cancleButton];
}

-(void)deleteContent{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Content" inManagedObjectContext:self.myDelegate.manageContext];
    
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createTime" ascending:NO];
    NSArray *sortDescriotors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriotors];
    
    NSError *error = nil;
    NSMutableArray *fetchResult = [[self.myDelegate.manageContext executeFetchRequest:request error:&error] mutableCopy];
    if (nil == fetchResult) {
        NSLog(@"error:%@, %@",error, [error userInfo]);
    }
    
    self.entities = fetchResult;
    
    //NSLog(@"the entities count:%d",[self.entities count]);
    NSMutableArray *contentArray = [[NSMutableArray alloc] init];
    for (Content *content in self.entities) {
        [contentArray addObject:content.tittle];
                NSLog(@"contentArray======%@",contentArray);
    }
    if (fetchResult.count > 0) {
        NSLog(@"result.......%@",fetchResult);
        Content *entiy = [fetchResult objectAtIndex:self.Contentrow];
        [contentArray removeObjectAtIndex:self.Contentrow];
//        self.TextViewField.text = entity;
        NSLog(@"contentArray============%@",contentArray);

        
        [self.myDelegate.manageContext deleteObject:entiy];
        
        
    }
    
    if ((self.Contentrow)==([self.entities count]-1)) {
        self.TextViewField.text = [contentArray objectAtIndex:(self.Contentrow - 1)];

    }else{
        self.TextViewField.text = [contentArray objectAtIndex:self.Contentrow];
    }
}

-(void)deleteco{
    [childView setHidden:YES];
    [self.view setAlpha:1];
    NSLog(@"delete");
    [self deleteContent];

}

-(void)cancle{
    [childView setHidden:YES];
    [self.view setAlpha:1];
    NSLog(@"cancle");
}

- (IBAction)AlertViewHide:(UITapGestureRecognizer *)sender {
    [self.TapGesture setNumberOfTouchesRequired:0];
    [childView setHidden:YES];
    [self.view setAlpha:1];
}

- (IBAction)TextFieldDone:(UIBarButtonItem *)sender {
    [self.TextViewField resignFirstResponder];
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.TextViewField.text = textString;
    NSLog(@"row..............%ld",(long)self.Contentrow);

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.myDelegate = (NoteAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"nonVtext:%@",self.nonVtext);
    NSLog(@"vtext:%@",self.Vtext);
    
    
    NSString *value = self.nonVtext;
    
    
    if ([value isEqualToString:@"nonValue"]) {
        [self.funcToolBar setHidden:YES];
    }else{
        [self.funcToolBar setHidden:NO];
    }
}

#pragma guo -
#pragma guo Text View delegate methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"iiiii");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(barRightButtonItemClicked)];
    return YES;
}

-(void)fetchRequestResult:(NSString *)content{
    
    //更新谁的条件在这里配置；

    self.myDelegate = (NoteAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Content" inManagedObjectContext:self.myDelegate.manageContext];
    
    [request setEntity:entity];
    
    NSString *theName = content;
    [request setPredicate:[NSPredicate predicateWithFormat:@"name==%@", theName]];
    
    NSError* error = nil;
    

    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createTime" ascending:NO];
    NSArray *sortDescriotors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriotors];
    

    NSMutableArray *fetchResult = [[self.myDelegate.manageContext executeFetchRequest:request error:&error] mutableCopy];
    if (nil == fetchResult) {
        NSLog(@"error:%@, %@",error, [error userInfo]);
    }

    
    if (fetchResult.count > 0) {
        NSLog(@"result%@",fetchResult);
        Content *entiy = [fetchResult objectAtIndex:0];
        entiy.tittle = @"your address is update to JiNan";
        entiy.content = @"hhhh";
        entiy.createTime = [NSDate date];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    //[self Query];
    
   // [self.funcToolBar setHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)Query
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Content" inManagedObjectContext:self.myDelegate.manageContext];
    
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createTime" ascending:NO];
    NSArray *sortDescriotors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriotors];
    
    NSError *error = nil;
    NSMutableArray *fetchResult = [[self.myDelegate.manageContext executeFetchRequest:request error:&error] mutableCopy];
    if (nil == fetchResult) {
        NSLog(@"error:%@, %@",error, [error userInfo]);
    }
    
    self.entities = fetchResult;
    
    NSLog(@"the entities count:%lu",(unsigned long)[self.entities count]);
    for (Content *content in self.entities) {
        NSLog(@"%@---tittle----%@----content-----%@-----date",content.tittle, content.content, content.createTime);
    }
}

//更新：直接修改对象，保存managedObjectContext就好
-(void)updateContent{
    [self Query];
    //修改后，直接保存managedObjectContext就可以了
    //content.tittle = self.TextViewField.text;
    //content.createTime = [NSDate date];
//    [content setTittle:self.TextViewField.text];
//    [content setContent:self.TextViewField.text];
//    [content setCreateTime:[NSDate date]];
    NSLog(@"text%@",self.TextViewField.text);
    
    self.myDelegate = (NoteAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Content" inManagedObjectContext:self.myDelegate.manageContext]];
    
    NSString *theName = self.Vtext;
    [request setPredicate:[NSPredicate predicateWithFormat:@"tittle==%@", theName]];
    
    NSError *error = nil;
    if (![self.myDelegate.manageContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    NSMutableArray *fetchResult = [[self.myDelegate.manageContext executeFetchRequest:request error:&error] mutableCopy];
    NSLog(@"result%@",fetchResult);
    if (nil == fetchResult) {
        NSLog(@"error:%@, %@",error, [error userInfo]);
    }
//    
//    
    if (fetchResult.count > 0) {
        NSLog(@"result%@",fetchResult);
        Content *entiy = [fetchResult objectAtIndex:0];
        entiy.tittle = self.TextViewField.text;
        entiy.content = self.TextViewField.text;
        entiy.createTime = [NSDate date];
    }
    
    
    NSLog(@"update success");
    //[self Query];
}

- (void)barRightButtonItemClicked{
    
    [self.TextViewField resignFirstResponder];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
    
    
    NSLog(@"vrrrrrtext:%@",self.nonVtext);
    NSLog(@"vtext:%@",self.Vtext);
    NSString *value = self.nonVtext;
    
    
    if ([value isEqualToString:@"nonValue"]) {
        [self.funcToolBar setHidden:NO];
            Content *content = (Content *)[NSEntityDescription insertNewObjectForEntityForName:@"Content" inManagedObjectContext:self.myDelegate.manageContext];
        [content setTittle:self.TextViewField.text];
        [content setContent:self.TextViewField.text];
        [content setCreateTime:[NSDate date]];
        
        NSError *error;
        
        BOOL isSaveSuccess = [self.myDelegate.manageContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"error:%@, %@",error, [error userInfo]);
        }else{
            NSLog(@"save success.");
            
        }
    }else{
        [self.funcToolBar setHidden:YES];
        [self updateContent];
    }
    [self Query];
    
    NSLog(@"click");
    [self.funcToolBar setHidden:NO];
}

/**********************************************************/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
