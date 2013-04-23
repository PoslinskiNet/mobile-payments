//
//  DemoZooZSDKViewController.m
//  DemoZooZSDK
//
//  Created by Ronen Morecki on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoZooZSDKViewController.h"


#define IS_SANDBOX YES

#define APP_KEY @"b7319a28-44e8-484a-9e92-99f3cc151307"

@implementation DemoZooZSDKViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    //optional pre init, so the ZooZ screen will upload immediatly, you can skip this call
    ZooZ * zooz = [ZooZ sharedInstance];
    [zooz preInitialize:APP_KEY isSandboxEnv:IS_SANDBOX];

}

-(IBAction)buyMore{
	paymentSuccessLabel.hidden = YES;
	
	ZooZ * zooz = [ZooZ sharedInstance];
    
    zooz.sandbox = IS_SANDBOX;
    
    zooz.tintColor = [UIColor colorWithRed:1 green:0.8 blue:0 alpha:1];
    
    zooz.barButtonTintColor = [UIColor darkGrayColor];
    
    //optional image that will be displayed on the NavigationBar as your logo
//    zooz.barTitleImage = [UIImage imageNamed:@"MyLogo.png"];
    
    ZooZPaymentRequest * req = [zooz createPaymentRequestWithTotal:1.0 invoiceRefNumber:@"Selleo test invoice" delegate:self];
    
    /*
    //If you want only to allow regsiter cards and not do payment use this instead of the above:
    ZooZPaymentRequest * req = [zooz createManageFundSourcesRequestWithDelegate:self];
    */
    
    req.currencyCode = @"EUR";
    
    req.payerDetails.firstName = @"Some";
    
    req.payerDetails.email = @"sdk@skrzynka.pl";
    
    req.payerDetails.billingAddress.zipCode=@"01234";
    
    req.requireAddress = YES; //set if to ask for zip code or not from the payer.
    
    ZooZInvoiceItem * item = [ZooZInvoiceItem invoiceItem:12.1 quantity:1 name:@"T-Shirt"];
    item.additionalDetails = @"Free 200 characters custom description";
    item.itemId = @"refId-12345678"; // optional
    
    [req addItem:item];
    
    req.invoice.additionalDetails = @"Custom invoice description text";
        
    [zooz openPayment:req forAppKey:APP_KEY];
    
}
- (void)openPaymentRequestFailed:(ZooZPaymentRequest *)request withErrorCode:(int)errorCode andErrorMessage:(NSString *)errorMessage{
	NSLog(@"failed: %@", errorMessage);
    //this is a network / integration failure, not a payment processing failure.
	
}

//Called in the background thread - before user closes the payment dialog
//Do not refresh UI at this callback - see paymentSuccessDialogClosed
- (void)paymentSuccessWithResponse:(ZooZPaymentResponse *)response{
    
	NSLog(@"payment success with payment Id: %@, %@, %@, %f %@", response.transactionDisplayID, response.fundSourceType, response.lastFourDigits, response.paidAmount, response.transactionID);
}

//called after successful payment and after the user closed the payment dialog
//Do the UI changes on success at this point
-(void)paymentSuccessDialogClosed{
    NSLog(@"Payment dialog closed after success");
    //see paymentSuccessWithResponse: for the response transaction ID. 
   	paymentSuccessLabel.hidden = NO;
}

- (void)paymentCanceled{
	NSLog(@"payment cancelled");
    //dialog closed without payment completed
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



- (void)dealloc {
	[paymentSuccessLabel release];
    [super dealloc];
}

@end
