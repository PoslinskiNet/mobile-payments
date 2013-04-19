//
//  RootViewController.m
//  VoucherMill
//
//  Created by PayMill on 3/7/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import "PMCoreDataViewController.h"
#import <PayMillSDK/PMTransaction.h>
#import <CoreData/NSEntityDescription.h>
#import "Transaction.h"
#import "PMAppDelegate.h"

@interface PMCoreDataViewController ()

@end

@implementation PMCoreDataViewController
@synthesize managedObjectContext;
@synthesize tableData;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.hidesBackButton = YES;
    
    // Set the title.
    self.title = @"Saved Transactions";
    
    tableData = [[NSMutableArray alloc] init];
        
    [self load];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if( cell == nil ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    SavedTransaction *strans = (SavedTransaction *)[tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", strans.transactionType, strans.transactionID];
    NSString *voucherType_str = [NSString stringWithFormat:@"%d", strans.voucherType.intValue/100];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Voucher value: %@€", voucherType_str];
    
    return cell;
}



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

-(void)load
{
    [tableData removeAllObjects]; // Remove all previous objects to avoid duplication
    
    PMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
 
    for( NSManagedObject *info in fetchedObjects)
    {
        SavedTransaction *strans = [[SavedTransaction alloc] init];
        strans.transactionID = [info valueForKey:@"transactionID"];
        strans.transactionType = [info valueForKey:@"transactionType"];
        strans.voucherType = [info valueForKey:@"voucherType"];
        
        [tableData addObject: strans];
    }

    [_myTable reloadData];
    
}

@end
