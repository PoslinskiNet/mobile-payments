//
//  PMAuthorizationViewController.m
//  VoucherMill
//
//  Created by PayMill on 3/5/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import "PMAuthorizationViewController.h"
#import <PayMillSDK/PMManager.h>
@interface PMAuthorizationViewController ()

@end

@implementation PMAuthorizationViewController

@synthesize merchPubKey;

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
	// Do any additional setup after loading the view
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authorization:(id)sender
{	
	[PMManager initWithTestMode:TRUE merchantPublicKey:merchPubKey.text newDeviceId:nil
						   init:^(BOOL success, PMError *error) {
							   NSLog(@"OnInit");
							   if(!success)
							   {
								   //Init failed: error.code, error.message
								   NSString *initFailureMsg = [NSString stringWithFormat:@"Init failed: type: %d, message: %@", error.type, error.message];
								   UIAlertView *initFailure = [[UIAlertView alloc]
															   initWithTitle:@"Alert"
															   message:initFailureMsg
															   delegate:nil
															   cancelButtonTitle:@"OK"
															   otherButtonTitles:nil];
								   
								   // shows alert to user
								   [initFailure show];
							   }
							   
						   } success:^(NSArray *notConsumedTransactions) {
							   NSLog(@"OnSuccess");
						   } failure:^(PMError *error) {
							   //Get non consumed transaction failed
							   NSLog(@"OnFailure");
							   NSString *initFailureMsg = [NSString stringWithFormat:@"Get non consumed transaction failed: type: %d, message: %@", error.type, error.message];
							   UIAlertView *initFailure = [[UIAlertView alloc]
														   initWithTitle:@"Alert"
														   message:initFailureMsg
														   delegate:nil
														   cancelButtonTitle:@"OK"
														   otherButtonTitles:nil];
							   
							   // shows alert to user
							   [initFailure show];
						   } success:^(NSArray *notConsumedPreauthorizations) {
							   NSLog(@"OnSuccess");
						   } failure:^(PMError *error) {
							   //Get non consumed transaction failed
							   NSLog(@"OnFailure");
							   NSString *initFailureMsg = [NSString stringWithFormat:@"Get non consumed transaction failed: type: %d, message: %@", error.type, error.message];
							   UIAlertView *initFailure = [[UIAlertView alloc]
														   initWithTitle:@"Alert"
														   message:initFailureMsg
														   delegate:nil
														   cancelButtonTitle:@"OK"
														   otherButtonTitles:nil];
							   
							   // shows alert to user
							   [initFailure show];
						   }];
}
- (void)viewDidUnload {
    [self setMerchPubKey:nil];
    [super viewDidUnload];
}
@end
