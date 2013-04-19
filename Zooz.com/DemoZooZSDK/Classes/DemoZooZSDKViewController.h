//
//  DemoZooZSDKViewController.h
//  DemoZooZSDK
//
//  Created by Ronen Morecki on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZooZSDK/ZooZ.h>

@interface DemoZooZSDKViewController : UIViewController <ZooZPaymentCallbackDelegate>{
	IBOutlet UILabel * paymentSuccessLabel;
	
}

-(IBAction)buyMore;

@end

