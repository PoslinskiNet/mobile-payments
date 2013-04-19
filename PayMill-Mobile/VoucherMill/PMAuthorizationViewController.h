//
//  PMAuthorizationViewController.h
//  VoucherMill
//
//  Created by PayMill on 3/5/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMAuthorizationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *merchPubKey;

- (IBAction)authorization:(id)sender;
@end
