//
//  PMNewItemViewController.m
//  VoucherMill
//
//  Created by Stefan Stefanov on 1/30/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import "PMNewItemViewController.h"
#import "PMItem.h"

@interface PMNewItemViewController ()
@property(strong)NSArray *items;
@end

@implementation PMNewItemViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PMItem *i1 = [[PMItem alloc] initItem:@"Item 1" description:@"description of item 1"];
    PMItem *i2 = [[PMItem alloc] initItem:@"Second Item" description:@"description of second item"];
    PMItem *i3 = [[PMItem alloc] initItem:@"Item 3" description:@"description of item 3"];
    //    PMItem *i4 = [[PMItem alloc] initItem:@"Other Item" description:@"description of item 4"];
    //    PMItem *i5 = [[PMItem alloc] initItem:@"Item Number 5" description:@"description of item 5"];
    //
    //    PMItem *i6 = [[PMItem alloc] initItem:@"666" description:@"description of item"];
    //    PMItem *i7 = [[PMItem alloc] initItem:@"777" description:@"description of item"];
    //    PMItem *i8 = [[PMItem alloc] initItem:@"Item 8" description:@"description of item"];
    //    PMItem *i9 = [[PMItem alloc] initItem:@"Item 9" description:@"description of item"];
    //    PMItem *i10 = [[PMItem alloc] initItem:@"Item 10" description:@"description of item"];
    //
    //    PMItem *i11 = [[PMItem alloc] initItem:@"Item 11" description:@"description of item"];
    //    PMItem *i12 = [[PMItem alloc] initItem:@"Item 12" description:@"description of item"];
    
    //    self.items = [NSArray arrayWithObjects:i1,i2,i3,i4,i5, i6, i7, i8, i9, i10, i11, i12, nil];
    self.items = [NSArray arrayWithObjects:i1,i2,i3, nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    PMItem *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.itemName;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
