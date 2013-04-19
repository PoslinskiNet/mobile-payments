//
//  PMDetailViewController.m
//  VoucherMill
//
//  Created by PayMill on 1/30/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import "PMDetailViewController.h"
#import "PMAppDelegate.h"

#import "PMPaymentViewController.h"

@interface PMDetailViewController ()

@end

@implementation PMDetailViewController

@synthesize itemLabel;
@synthesize itemDetails;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    itemLabel.text = itemDetails.itemName;
    _itemDetailsLabel.text = itemDetails.description;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)purchase:(id)sender
{
    PMPaymentViewController *paymentViewController = [[PMPaymentViewController alloc] initWithStyle:(UITableViewStyleGrouped)];
    paymentViewController.genTokenOnly = false;
    PMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    paymentViewController.voucherValue = delegate.voucherValue;
    paymentViewController.isPreuthorization = delegate.isPreuthorization;
    [self.navigationController pushViewController:paymentViewController animated:YES];
}

- (IBAction)onTestBtn:(id)sender
{
    NSLog(@"ToPayMillStoryboard from the button");
    
}
@end
