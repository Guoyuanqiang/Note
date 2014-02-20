//
//  NoteAddContentViewController.m
//  Note
//
//  Created by 郭远强 on 14-2-4.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import "NoteAddContentViewController.h"
#import "NotePageViewController.h"
#import "Content.h"


@interface NoteAddContentViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextField;
@property (weak, nonatomic) IBOutlet UIToolbar *funcToolBar;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *TapGesture;
@property (weak, nonatomic) NSMutableArray *entities;
@end

@implementation NoteAddContentViewController
@synthesize Contentrow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self performSegueWithIdentifier:@"BackToNotePage" sender:self];
        NSLog(@"ggggggg");
    }
    return self;
}

- (IBAction)addContentPage:(UIBarButtonItem *)sender {
    NoteAddContentViewController *notePageView = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteAddContent"];
    [self.navigationController pushViewController:notePageView animated:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Note" style:UIButtonTypeCustom target:self action:@selector(backToNotePage)];
}
- (IBAction)deleteContent:(UIBarButtonItem *)sender {
    NSLog(@"gesture.................");
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
    [self.TapGesture setEnabled:YES];

}

-(void)deleteContent{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Content" inManagedObjectContext:self.myContentDelegate.manageContext];
    
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createTime" ascending:NO];
    NSArray *sortDescriotors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriotors];
    
    NSError *error = nil;
    NSMutableArray *fetchResult = [[self.myContentDelegate.manageContext executeFetchRequest:request error:&error] mutableCopy];
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
        
        
        [self.myContentDelegate.manageContext deleteObject:entiy];
        
        
    }
    
    if ((self.Contentrow)==([self.entities count]-1)) {
        self.contentTextField.text = [contentArray objectAtIndex:(self.Contentrow - 1)];
        
    }else{
        self.contentTextField.text = [contentArray objectAtIndex:self.Contentrow];
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

- (IBAction)childViewHide:(UITapGestureRecognizer *)sender {
    NSLog(@"hide.........");
    [self.TapGesture setNumberOfTouchesRequired:0];
    [childView setHidden:YES];
    [self.view setAlpha:1];
    NSLog(@"hide..........");
}

#pragma guo -
#pragma guo Text View delegate methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"iiiii");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(barRightButtonItemClicked)];
    return YES;
}

-(void)backToNotePage{
//    NotePageViewController *notePageView = [self.storyboard instantiateViewControllerWithIdentifier:@"NotePageCell"];
//    [self.navigationController pushViewController:notePageView animated:YES];
    
    NSLog(@"pageCount=============%lu",(unsigned long)[self.navigationController.viewControllers count]);
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -([self.navigationController.viewControllers count]-1))] animated:YES];
    pageCount=pageCount+1;
    NSLog(@"pagecount=====%d",pageCount);

}



- (void)viewDidLoad
{
    [self.funcToolBar setHidden:YES];
    [self.TapGesture setEnabled:NO];
    pageCount = 0;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Note" style:UIButtonTypeCustom target:self action:@selector(backToNotePage)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonSystemItemDone target:self action:nil];
    self.myContentDelegate = (NoteAppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{

}

- (IBAction)TextFieldDone:(UIBarButtonItem *)sender {
    [self.contentTextField resignFirstResponder];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
}

- (void)barRightButtonItemClicked{

    [self.contentTextField resignFirstResponder];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];

    
    
   // if ([value isEqualToString:@"nonValue"]) {
        Content *content = (Content *)[NSEntityDescription insertNewObjectForEntityForName:@"Content" inManagedObjectContext:self.myContentDelegate.manageContext];
        [content setTittle:self.contentTextField.text];
        [content setContent:self.contentTextField.text];
        [content setCreateTime:[NSDate date]];
        
        NSError *error;
        
        BOOL isSaveSuccess = [self.myContentDelegate.manageContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"error:%@, %@",error, [error userInfo]);
        }else{
            NSLog(@"save success.");
            
        }
    //}
    NSLog(@"click");
    [self.funcToolBar setHidden:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
