//
//  PMPaymentViewController.h
//  VoucherMill
//
//  Created by PayMill on 3/26/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PaymentTypes) {
    ALL,
    CC_VISA,
    CC_MASTERCARD,
    DD_DE
};

@interface PMPaymentViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    bool isDirectDebitSelected;
}

@property (nonatomic) int selectedPaymentType;
@property (nonatomic, strong)   UITableViewCell *selectedCell;
@property (nonatomic) bool genTokenOnly;

//Shown payment types
@property (nonatomic) PaymentTypes paymentType;

//
@property (nonatomic) NSString *mainmenuViewControllerName;
@property (nonatomic) NSString *mainmenuStoryboardName;
@property (nonatomic) Class mainmenuClass;

@property (nonatomic) bool isPreuthorization;
@property (nonatomic) int voucherValue;

@end
