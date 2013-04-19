//
//  PMMainMenuViewController.m
//  VoucherMill
//
//  Created by PayMill on 3/13/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import "PMMainMenuViewController.h"
#import <PayMillSDK/PMManager.h>
#import "PMAppDelegate.h"
#import "PMTransListViewController.h"
#import "PMPaymentViewController.h"
#import "Transaction.h"

@interface PMMainMenuViewController ()

@end

@implementation PMMainMenuViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *segueIdentifier;
    switch (indexPath.row) {
        case 0: // Buy Voucher
            segueIdentifier = @"BuyVoucher";
            break;
            
        case 1: // Preauthorize Voucher
            segueIdentifier = @"PreauthorizeVoucher";
            break;
            
        case 2:
            segueIdentifier = @"ListBoughtOnline";
            break;
            
        case 3:
            segueIdentifier = @"ListPreauthorized";
            break;
            
        case 4:
            segueIdentifier = @"ListBoughtOffline";
            break;
            
        case 5:
            segueIdentifier = @"GenerateToken";
            break;
                        
        default:
            break;
    }
    
    if([self _shouldPerformSegueWithIdentifier:segueIdentifier sender:self])
        [self performSegueWithIdentifier:segueIdentifier sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ListBoughtOnline"] || [segue.identifier isEqualToString:@"ListPreauthorized"])
    {
        PMTransListViewController *destViewController = segue.destinationViewController;
        destViewController.items = transList;
    }
}

- (BOOL)_shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{    
    if ([identifier isEqualToString:@"GenerateToken"])
    {        
        PMPaymentViewController *paymentViewController = [[PMPaymentViewController alloc] initWithStyle:(UITableViewStyleGrouped)];
        paymentViewController.genTokenOnly = true;
        [self.navigationController pushViewController:paymentViewController animated:YES];
        
        return NO;
    }
    
    if ([identifier isEqualToString:@"ListBoughtOnline"])
    {
        NSLog(@"ListBoughtOnline");
        
        isDone = NO;
        
        [PMManager getTransactionsList:^(NSArray *transactions) {
            transList = transactions;
            isDone = YES;
         
            [self performSegueWithIdentifier:@"ListBoughtOnline" sender:self];

        } failure:^(PMError *error) {
            NSLog(@"getTransactionsList Failure! Error type: %d, error message: %@", error.type, error.message);
            
            UIAlertView *tlistAlert = [[UIAlertView alloc]
                                       initWithTitle:[NSString stringWithFormat: @"Get transactions failure: %d", error.type]
                                       message:error.message
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [tlistAlert show];
        }];
        
        return isDone;
    }

    if ([identifier isEqualToString:@"ListPreauthorized"])
    {
        NSLog(@"ListPreauthorized");

        [PMManager getPreauthorizationsList:^(NSArray *transactions){
            transList = transactions;
            
            [self performSegueWithIdentifier:@"ListPreauthorized" sender:self];
        } onFailure:^(PMError *error) {
            NSLog(@"getPreauthorizationsList Failure! Error type: %d, error message: %@", error.type, error.message);
           
            
            UIAlertView *plistAlert = [[UIAlertView alloc]
                                       initWithTitle:[NSString stringWithFormat: @"Get preauthorizations failure: %d", error.type]
                                       message:error.message
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [plistAlert show];
        }];
        return NO;
    }
    
    if ([identifier isEqualToString:@"ListBoughtOffline"])
    {
        NSLog(@"ListBoughtOffline");
                
        [PMManager getNonConsumedTransactionsList:^(NSArray *notConsumedTransactions) {
            PMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context = [delegate managedObjectContext];
            
            transList = notConsumedTransactions;
            
            for (PMTransaction *trans in notConsumedTransactions)
            {
                NSManagedObject *record = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
                
                [record setValue:trans.id forKey:@"transactionID"];
                [record setValue:@"Transaction" forKey:@"transactionType"];
                [record setValue:trans.amount forKey:@"voucherType"];
                NSError *err;
                
                if( ! [context save:&err] )
                {
                    NSLog(@"Cannot save data: %@", [err localizedDescription]);
                    
                    UIAlertView *plistAlert = [[UIAlertView alloc]
                                               initWithTitle:[NSString stringWithFormat: @"Can not save non consumed transaction in DB:"]
                                               message:[err localizedDescription]
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                    [plistAlert show];
                }
                else
                {
                    [PMManager consumeTransactionForId:trans.id success:^(NSString *id) {
                        NSLog(@"Successfuly consumed transaction %@", id);
                        
                    } failure:^(PMError *error) {
                        NSLog(@"Consume transaction failure, error type: %u, error message: %@", error.type, error.message);
                    }];
                }
            }
         
            [self performSegueWithIdentifier:@"ListBoughtOffline" sender:self];

        } failure:^(PMError *error) {
            NSLog(@"getNonConsumedTransactionsList Failure! Error type: %d, error message: %@", error.type, error.message);
            
            
            UIAlertView *plistAlert = [[UIAlertView alloc]
                                       initWithTitle:[NSString stringWithFormat: @"Get non consumed transactions list failure: %d", error.type]
                                       message:error.message
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [plistAlert show];

        }];
        
        return NO;
    }
    
    if([identifier isEqualToString:@"BuyVoucher"])
    {
        NSLog(@"BuyVoucher");
        
        PMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.isPreuthorization = NO;
    }
    
    if([identifier isEqualToString:@"PreauthorizeVoucher"])
    {
        NSLog(@"PreauthorizeVoucher");

        PMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.isPreuthorization = YES;
    }
 
    return YES;
}

- (IBAction)back:(UIStoryboardSegue *)segue
{
    // Optional place to read data from closing controller
    
    NSLog(@"back");
}
@end
