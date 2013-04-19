//
//  PMItemsViewController.m
//  VoucherMill
//
//  Created by PayMill on 1/30/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import "PMItemsViewController.h"
#import "PMDetailViewController.h"
#import "PMItem.h"
#import "PMAppDelegate.h"

@interface PMItemsViewController ()
@property(strong)NSArray *items;
@property(strong)NSArray *values;
@end

@implementation PMItemsViewController

@synthesize itemDetails;

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

    PMItem *cinemaTicket = [[PMItem alloc] initItem:@"Cinema Ticket" description:@"Voucher: 10€" value:1000];
    PMItem *theatreTicket = [[PMItem alloc] initItem:@"Theatre Ticket" description:@"Voucher: 20€" value:2000];
    PMItem *sportTicket = [[PMItem alloc] initItem:@"Sport Ticket" description:@"Voucher: 20€" value:2000];
    PMItem *concertTicket = [[PMItem alloc] initItem:@"Concert Ticket" description:@"Voucher: 50€" value:5000];
    
    self.items = [NSArray arrayWithObjects: cinemaTicket, theatreTicket, sportTicket, concertTicket, nil];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"OrderItem"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PMDetailViewController *destViewController = segue.destinationViewController;
        destViewController.itemDetails = [_items objectAtIndex:indexPath.section];
        
        PMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.voucherValue = ((PMItem *)[_items objectAtIndex:indexPath.section]).value;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"Order" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
