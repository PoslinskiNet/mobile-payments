//
//  PMDetailViewController.h
//  VoucherMill
//
//  Created by PayMill on 1/30/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMItem.h"

@interface PMDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *itemLabel;
@property (nonatomic, strong) IBOutlet UILabel *itemDetailsLabel;
@property (nonatomic, strong) PMItem *itemDetails;
- (IBAction)purchase:(id)sender;

- (IBAction)onTestBtn:(id)sender;
@end
