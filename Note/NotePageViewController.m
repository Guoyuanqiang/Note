//
//  NotePageViewController.m
//  Note
//
//  Created by 郭远强 on 14-1-23.
//  Copyright (c) 2014年 郭远强. All rights reserved.
//

#import "NotePageViewController.h"
#import "NoteContentViewController.h"
#import "NoteAppDelegate.h"
#import "Content.h"

@interface NotePageViewController ()
@property (weak, nonatomic) NoteAppDelegate *myDelegate;
@property (weak, nonatomic) NSMutableArray *entities;
@end

@implementation NotePageViewController
@synthesize contentDatasource;
@synthesize timeDataSource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSLog(@"init.....");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.contentDatasource = array;
    [self fetchRequestResult];
    [self.tableView reloadData];//update the datasouce when tableviewcell show
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"NoteContent"]) {
        id segue2 = segue.destinationViewController;
        [segue2 setValue:@"nonValue" forKey:@"nonVtext"];
        NSLog(@"segue");
    }
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.contentDatasource count];
}

-(NSMutableArray *)fetchRequestResult{
    self.myDelegate = (NoteAppDelegate *)[[UIApplication sharedApplication] delegate];
    
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
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *timeArray = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatterW = [[NSDateFormatter alloc] init];
    [dateFormatterW setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    for (Content *content in self.entities) {
        NSString *dateString = [dateFormatterW stringFromDate:content.createTime];
        [timeArray addObject:dateString];
        
        [array addObject:content.tittle];
    }
    
    NSLog(@"string%@",array);
    self.contentDatasource = array;
    
    self.timeDataSource = timeArray;
    NSLog(@"timedatasource%@",self.timeDataSource);
    return self.timeDataSource;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellform");
    UITableViewCell *cell = nil;
    static NSString *NotePageCellIdentifier = @"NotePage";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NotePageCellIdentifier forIndexPath:indexPath];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NotePageCellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    NSString *rowData = [contentDatasource objectAtIndex:row];
    [cell.textLabel setText:rowData];
    
    
    
    NSString *timeRowData = [[self fetchRequestResult] objectAtIndex:row];
    [cell.detailTextLabel setText:timeRowData];
    
    //cell.detailTextLabel.text = [self.timeDataSource objectAtIndex:row];

//    for (Content *content in self.entities) {
//        NSDateFormatter *dateFormatterW = [[NSDateFormatter alloc] init];
//        [dateFormatterW setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSString *dateString = [dateFormatterW stringFromDate:content.createTime];
//        
//        [cell.detailTextLabel setText:dateString];
//        NSLog(@"time%@",dateString);
//        //NSLog(@"row%d",row);
//    }
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *buttonImage = [UIImage imageNamed:@"disclosureButton.png"];
//    CGRect buttonFrame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    button.frame = buttonFrame;
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    cell.accessoryView = button;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    NSDate *now = [NSDate date];
//    NSDateFormatter *dateFormatterW = [[NSDateFormatter alloc] init];
//    [dateFormatterW setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *dateString = [dateFormatterW stringFromDate:now];
    //NSLog(@"date:%@",dateString);
    // Configure the cell...
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    NoteContentViewController *noteContent = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteContent"];
    noteContent.textString = [contentDatasource objectAtIndex:row];
    noteContent.Vtext = noteContent.textString;//@"VALUE";
    noteContent.Contentrow = row;
    [self.navigationController pushViewController:noteContent animated:YES];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


//delete core data

- (void)deleteRowData:(NSInteger)row
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

    
    if (fetchResult.count > 0) {
        NSLog(@"result%@",fetchResult);
        Content *entiy = [fetchResult objectAtIndex:row];
        NSLog(@"delete row======%ld",(long)row);
        [self.myDelegate.manageContext deleteObject:entiy];
    }
    if (![self.myDelegate.manageContext save:&error]) {
        NSLog(@"error: %@,%@", error, [error userInfo]);
    }
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deleteRowData:row];
        [self.contentDatasource removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         [self.contentDatasource addObject:@"tttttt"];
        NSLog(@"llll");
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
