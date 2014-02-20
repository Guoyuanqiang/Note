//
//  NoteViewController.m
//  Note
//
//  Created by 郭远强 on 14-1-23.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import "NoteViewController.h"
#import "NotePageViewController.h"
@interface NoteViewController ()

@end

@implementation NoteViewController
@synthesize data;
- (void)viewDidLoad
{
    NSArray *array = [NSArray arrayWithObjects:@"All note", @"Gmail", @"My iPhone", nil];
    self.data = array;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


#pragma guo -
#pragma guo NoteViewController datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    static NSString *NoteViewControllerIdentifier = @"noteviewcontrolleridentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:NoteViewControllerIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoteViewControllerIdentifier];
    }
    
    NSInteger row = [indexPath row];
    NSString *cellValue = [self.data objectAtIndex:row];
    [cell.textLabel setText:cellValue];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *buttonImage = [UIImage imageNamed:@"disclosureImage.png"];
//    CGRect buttonFrame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    button.frame = buttonFrame;
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
//    cell.accessoryView = button;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
}

#pragma guo -
#pragma guo NoteViewController delegate methods
- (void)checkButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
	if (indexPath != nil)
	{
		[self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
	}
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NotePageViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotePageCell"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NotePageViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotePageCell"];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
