//
//  PMPaymentViewController.m
//  VoucherMill
//
//  Created by PayMill on 3/26/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import "PMPaymentViewController.h"

#import <PayMillSDK/PMSDK.h>

#define kPickerAnimationDuration 0.40

@interface PMPaymentViewController ()
{
    NSString *fnameStr;
    NSString *lnameStr;
    NSString *nameStr;
    NSString *accountStr;
    NSString *codeStr;
    NSString *expMonthStr;
    NSString *expYearStr;
    
    UITextField *editedField;
    
    UIActivityIndicatorView *progress;
}

@property (nonatomic, strong) IBOutlet UIPickerView *monthPickerView;
@property (nonatomic, strong) IBOutlet UIPickerView *yearPickerView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *submitButton;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *progress;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, retain) NSArray *pickerMonthArray;
@property (nonatomic, retain) NSArray *pickerYearArray;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation PMPaymentViewController

@synthesize progress;

@synthesize isPreuthorization;
@synthesize voucherValue;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// return the picker frame based on its size, positioned at the bottom of the page
- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(	0.0,
                                   screenRect.size.height - 42.0 - size.height,
                                   size.width,
                                   size.height);
	return pickerRect;
}

- (void)createPicker
{
    //Months must be in 2 digit [MM] format mandatory!
	self.pickerMonthArray = [NSArray arrayWithObjects: @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", nil];
	self.pickerYearArray = [NSArray arrayWithObjects: @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", nil];
    
	self.monthPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	self.yearPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
//    self.pickerViewArray = self.pickerMonthArray;
    
	self.monthPickerView.autoresizingMask = self.yearPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
   
	self.monthPickerView.showsSelectionIndicator = self.yearPickerView.showsSelectionIndicator = YES;	// note this is default to NO

	// this view controller is the data source and delegate
	self.monthPickerView.delegate = self.yearPickerView.delegate = self;
	self.monthPickerView.dataSource = self.yearPickerView.dataSource = self;
	
	self.monthPickerView.hidden = self.yearPickerView.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Setting default parameterers:
    if(self.mainmenuStoryboardName == nil)
        self.mainmenuStoryboardName = @"MainStoryboard";
    if(self.mainmenuViewControllerName == nil)
        self.mainmenuViewControllerName = @"MainMenu";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *payments;
    //Setting shown payment types, default ALL
    switch (self.paymentType)
    {
        case ALL:
            payments = [NSArray arrayWithObjects:@"VISA", @"Master Card", @"Direct Debit", nil];
            break;
        case CC_VISA:
            payments = [NSArray arrayWithObjects:@"VISA", nil];
            break;
        case CC_MASTERCARD:
            payments = [NSArray arrayWithObjects:@"Master Card", nil];
            break;
        case DD_DE:
            payments = [NSArray arrayWithObjects:@"Direct Debit", nil];
            isDirectDebitSelected = true;
            break;
            
        default:
            break;
    }
    
    self.dataArray = [NSArray arrayWithObjects:payments, \
                     [NSArray arrayWithObjects:NSLocalizedString(@"First Name", @"First Name"), NSLocalizedString(@"Last Name",@"Last Name"), nil], \
                     [NSArray arrayWithObjects:NSLocalizedString(@"Card Number", @"Card Number"), NSLocalizedString(@"Security Code", @"Security Code"), nil], \
                     [NSArray arrayWithObjects:NSLocalizedString(@"Month", @"Month"), NSLocalizedString(@"Year", @"Year"), nil], nil];

    
    [self createPicker];
    
    self.submitButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Submit", @"")
																   style:UIBarButtonItemStyleBordered
																  target:self
																  action:@selector(submitAction:)];
	self.navigationItem.rightBarButtonItem = self.submitButton;
    
    progress = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    [self.view addSubview:progress];
    progress.hidden = YES;
    progress.frame = screenRect;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:217.0/255.0 blue:223.0/255.0 alpha:1.0]];
    
    UIColor* color = [UIColor colorWithRed:215.0/255.0 green:217.0/255.0 blue:223.0/255.0 alpha:1.0];
    NSString* version = [[UIDevice currentDevice] systemVersion];
    if([version floatValue] < 6.0)
    {
        self.tableView.backgroundColor = color;
    }
    else    //workaround for background color in ver. 6.0
    {
        self.tableView.backgroundView = nil;
        UIView* bv = [[UIView alloc] init];
        bv.backgroundColor = color;
        self.tableView.backgroundView = bv;
    }
    
    //Temporary filling for test and debug purposes
    fnameStr = @"Max";
    lnameStr = @"Musterman";
    nameStr = [NSString stringWithFormat:@"%@ %@", fnameStr, lnameStr];
    accountStr = @"4711100000000000";
    codeStr = @"333";
    expMonthStr = @"12";
    expYearStr = @"14";
    [self.monthPickerView selectRow:11 inComponent:0 animated:YES];
    [self.yearPickerView selectRow:1 inComponent:0 animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections depends of direct debit or credit card payment type
    return isDirectDebitSelected ? 3 : 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)[self.dataArray objectAtIndex:section]).count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Payment Type", @"Payment Type");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Account Holder", @"Account Holder");
            break;
        case 2:
            sectionName = NSLocalizedString(@"Account Number", @"Account Number");
            break;
        case 3:
            sectionName = NSLocalizedString(@"Expiration Date", @"Expiration Date");
            break;
            
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Payment Type Section:
    static NSString *PTCellIdentifier = @"PaymentTypeCell";
    UITableViewCell *ptCell = [self.tableView dequeueReusableCellWithIdentifier:PTCellIdentifier];
    if (ptCell == nil)
    {
        ptCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:PTCellIdentifier];
        ptCell.accessoryType = UITableViewCellAccessoryNone;
    }
    if ([indexPath section] == 0)  // Payment Type Section
    {
        ptCell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        NSLog(@"selectedPaymentType: %d", self.selectedPaymentType);
        ptCell.selected = NO;
        if (indexPath.section == 0 && self.selectedPaymentType == indexPath.row)
            ptCell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            ptCell.accessoryType = UITableViewCellAccessoryNone;
        
        return ptCell;
    }
    
    // Payment Details Section:
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if ([indexPath section] >= 1)
    {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 162, 30)];
        textField.adjustsFontSizeToFitWidth = YES;
        textField.textColor = [UIColor blackColor];
        
        textField.delegate = self;
        cell.accessoryView = textField;
        
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
        cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        //Adding identification tag for every text field (note that there are possible 10 numbers per section)
        textField.tag = (indexPath.section * 10) + indexPath.row;
        
        switch ([indexPath section])
        {
            case 1: // Holder Name
                switch ([indexPath row])
                {
                    case 0: //First Name
                        textField.placeholder = isDirectDebitSelected ? NSLocalizedString(@"account holder", @"account holder") : NSLocalizedString(@"credit card holder", @"credit card holder");
                        textField.keyboardType = UIKeyboardTypeNamePhonePad;
                        textField.returnKeyType = UIReturnKeyNext;
                    
                        if(![fnameStr isEqualToString:@""])
                            textField.text = fnameStr;
                    
                        break;
                    
                    case 1: //Last Name
                        textField.placeholder = isDirectDebitSelected ? NSLocalizedString(@"account holder", @"account holder") : NSLocalizedString(@"credit card holder", @"account holder");
                        textField.keyboardType = UIKeyboardTypeNamePhonePad;
                        textField.returnKeyType = UIReturnKeyNext;
                    
                        if(![lnameStr isEqualToString:@""])
                            textField.text = lnameStr;
                        
                        break;
                    
                    default:
                        break;
                }
                break;
            
            case 2: //Payment Card
                switch(indexPath.row)
                {
                    case 0: // account number / credit card number
                        cell.textLabel.text = isDirectDebitSelected ? NSLocalizedString(@"Account No.", @"Account No.") : NSLocalizedString(@"Card Number", @"Card Number");
                        
                        textField.placeholder = isDirectDebitSelected ? NSLocalizedString(@"account number", @"account number") : NSLocalizedString(@"credit card number", @"credit card number");
                        textField.keyboardType = UIKeyboardTypeNumberPad;
                        textField.returnKeyType = UIReturnKeyNext;
                    
                        if(![accountStr isEqualToString:@""])
                            textField.text = accountStr;
                    
                        break;
                    
                    case 1: // bank code / CVC
                        cell.textLabel.text = isDirectDebitSelected ? NSLocalizedString( @"Bank code", @"Bank code") : NSLocalizedString(@"Security Code", @"Security Code");
                    
                        textField.placeholder = isDirectDebitSelected ? NSLocalizedString(@"bank code", @"bank code") : NSLocalizedString(@"CVC", @"CVC");
                        textField.keyboardType = UIKeyboardTypeNumberPad;
                        textField.returnKeyType = UIReturnKeyDone;
                    
                        if(![codeStr isEqualToString:@""])
                            textField.text = codeStr;
                    
                        break;
                    
                    default:
                        break;
                }
                break;
                
            case 3: //Expiration Date - optional, only for credit cards
                switch (indexPath.row)
                {
                    case 0:
                    {
                        textField.placeholder = NSLocalizedString( @"Select a month", @"Select a month");
                        textField.keyboardType = UIKeyboardTypeNumberPad;
                        textField.returnKeyType = UIReturnKeyDone;
                    
                        if(![expMonthStr isEqualToString:@""])
                            textField.text = expMonthStr;
                                                
                        break;
                    }
                    case 1:
                        textField.placeholder = NSLocalizedString( @"Select a year", @"Select a year");
                        textField.keyboardType = UIKeyboardTypeNumberPad;
                        textField.returnKeyType = UIReturnKeyDone;
                    
                        if(![expYearStr isEqualToString:@""])
                            textField.text = expYearStr;
                                                
                        break;
                        
                    default:
                        break;
                        
                }
                break;
        }
        
        textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        textField.textAlignment = UITextAlignmentLeft;
        
        textField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
                
        [cell.contentView addSubview:textField];
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.selectedCell != nil)
        self.selectedCell.accessoryType = UITableViewCellAccessoryNone;
    
    self.selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    //Get selected payment type
    if (indexPath.section == 0)
    {
        self.selectedPaymentType = indexPath.row;

        if((self.paymentType == ALL && indexPath.row == 2) || (self.paymentType == DD_DE))
            isDirectDebitSelected = YES;
        else
            isDirectDebitSelected = NO;
    }
    self.selectedCell.selected = NO;
    
    //Set checkmark for selected payment type
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell* selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0 && self.selectedPaymentType == indexPath.row)
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        selectedCell.accessoryType = UITableViewCellAccessoryNone;

    [tableView reloadData];
}

- (bool)inputVerification
{
    BOOL segueShouldOccur = YES|NO;
    NSString *msg = @"Please enter:";
    
    if([accountStr isEqualToString:@""])
    {
        msg = [msg stringByAppendingString:isDirectDebitSelected ? @"account number," : @" credit card number,"];
        segueShouldOccur = NO;
    }
    else
        if(!isDirectDebitSelected && [self luhnCheck:accountStr] == 0) // && != @"0"
        {
            msg = [msg stringByAppendingString:@" correct credit card number,"];
            segueShouldOccur = NO;
        }
    
    if([codeStr isEqualToString:@""])
    {
        msg = [msg stringByAppendingString:isDirectDebitSelected ? @" bank code," : @" CVC,"];
        segueShouldOccur = NO;
    }
    
    if([nameStr isEqualToString:@""])   // or [fnameStr isEqualToString:@""] || [lnameStr isEqualToString:@""])
    {
        msg = [msg stringByAppendingString:@" name,"];
        segueShouldOccur = NO;
    }
    
    if(!isDirectDebitSelected && ([expMonthStr isEqualToString:@""] || [expYearStr isEqualToString:@""]))
    {
        msg = [msg stringByAppendingString:@" expiration date,"];
        segueShouldOccur = NO;
        
    }
    
    NSDate *date = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    NSInteger year = [dateComponents year];
    NSInteger month = [dateComponents month];
    
    NSLog(@"Current year is %d and current month is %d", year, month);
    NSLog(@"expYearStr.intValue = %d, expMonthStr.intValue = %d", expYearStr.intValue, expMonthStr.intValue);
    
    if (!isDirectDebitSelected && (expMonthStr.length > 2 || expYearStr.length > 2))
    {
        segueShouldOccur = NO;
        msg = @"Incorrect expiration date!";
    }
    
    NSString *expYear2000Str = [NSString stringWithFormat:@"20%@", expYearStr];
    
    //Verification for expiration date of the credit card
    if(!isDirectDebitSelected && ![expYear2000Str isEqualToString:@""] && ![expMonthStr isEqualToString:@""] && (expYear2000Str.intValue < year ||
                                                                                                                 (expYear2000Str.intValue == year && expMonthStr.intValue < month)))
    {
        segueShouldOccur = NO;
        msg = NSLocalizedString(@"The credit card has expired!", @"The credit card has expired!");
    }
    
    //Verification for incorrect length of the account/credit card number or cvc
    if(isDirectDebitSelected)
    {
        if(accountStr.length > 16)  //16???
        {
            segueShouldOccur = NO;
            msg = NSLocalizedString(@"The account number is too long!", @"The account number is too long!");
        }
    }else
    {
        if(codeStr.length > 3)
        {
            segueShouldOccur = NO;
            msg = NSLocalizedString(@"CVC number is too long!", @"CVC number is too long!");
        }
        if(accountStr.length > 16)
        {
            segueShouldOccur = NO;
            msg = NSLocalizedString(@"The credit card number is too long!", @"The credit card number is too long!");
        }
    }
    
    if (!segueShouldOccur)
    {
        msg = [msg stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
        msg = [msg stringByAppendingString:@"!"];
        
        UIAlertView *notPermitted = [[UIAlertView alloc]
                                     initWithTitle:@"Alert"
                                     message:msg
                                     delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
        
        [notPermitted show];
    }

    return segueShouldOccur;
}

- (IBAction)submitAction:(id)sender
{
    NSLog(@"Submit");

    //Update data from last edited text field
    [self textFieldDidEndEditing:editedField];

    //Input verification
    if(!self.inputVerification)
        return;
            
    PMError *error;
    
    //Create payment method
    id paymentMethod = isDirectDebitSelected ? [PMFactory genNationalPaymentWithAccNumber:accountStr accBank:codeStr accHolder:nameStr accCountry:@"" error:&error] : [PMFactory genCardPaymentWithAccHolder:nameStr cardNumber:accountStr expiryMonth:expMonthStr expiryYear:[NSString stringWithFormat:@"20%@", expYearStr] verification:codeStr error:&error];
    
    if(voucherValue == 0)
        voucherValue = 100;
    
    //Create payment parameters
    PMPaymentParams *params = [PMFactory genPaymentParamsWithCurrency:@"EUR" amount:voucherValue description:@"Test payment" error:&error];
    
    [progress startAnimating];
    
    //Generate token use case
    if(self.genTokenOnly)
    {
        [PMManager generateTokenWithMethod:(paymentMethod)
                                parameters:params
                                   success:^(NSString *token){
                                       NSLog(@"generateToken success");
                                       NSLog(@"Generated token: %@", token);
                                       
                                       UIAlertView *tokenAlert = [[UIAlertView alloc]
                                                                  initWithTitle:@"Generated Token"
                                                                  message:token
                                                                  delegate:nil
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                                       [tokenAlert show];
                                       [self returnToInitView];
                                   }
                                   failure:^(PMError *error) {
                                       NSLog(@"generateToken failure! Error type: %d, error message: %@", error.type, error.message);
                                       
                                       [progress stopAnimating];
                                       
                                       UIAlertView *tokenAlert = [[UIAlertView alloc]
                                                                  initWithTitle:[NSString stringWithFormat: @"Generate token error type: %d", error.type]
                                                                  message:error.message
                                                                  delegate:nil
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                                       [tokenAlert show];
                                   }];
        return;
    }
    
    //Create transaction/preauthorization use cases
    if (isPreuthorization == NO)
    {
        //create transaction
        [PMManager transactionWithMethod:paymentMethod parameters:params consumable:TRUE
                                 success:^(PMTransaction *transaction) {
                                     NSAssert(transaction.id, @"Transaction is nil!");
                                     NSLog(@"Transaction created with method: %@", transaction.id);
                                     
                                     UIAlertView *tokenAlert = [[UIAlertView alloc]
                                                                initWithTitle:@"Transaction created"
                                                                message:transaction.id
                                                                delegate:nil
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles:nil];
                                     [tokenAlert show];
                                     
                                     [self returnToInitView];
                                 }
                                 failure:^(PMError *error) {
                                     NSAssert(error, @"Error message not implemented!");
                                     NSLog(@"Preathorization with method failure. PMError type: %i  message: %@", error.type, error.message);
                                     
                                     [progress stopAnimating];
                                     
                                     UIAlertView *transAlert = [[UIAlertView alloc]
                                                                initWithTitle:[NSString stringWithFormat: @"Generate transaction error type: %d", error.type]
                                                                message:error.message
                                                                delegate:nil
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles:nil];
                                     [transAlert show];
                                 }];
    }
    else
    {
        //create preauthorization
        [PMManager preauthorizationWithMethod:paymentMethod parameters:params consumable:TRUE
                                      success:^(PMTransaction *transaction) {
                                          NSAssert(transaction.id, @"Transaction is nil!");
                                          NSLog(@"Transaction created with method: %@", transaction.id);
                                          
                                          UIAlertView *tokenAlert = [[UIAlertView alloc]
                                                                     initWithTitle:@"Preauthorization created"
                                                                     message:transaction.id
                                                                     delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil];
                                          [tokenAlert show];
                                          [self returnToInitView];
                                      }
                                      failure:^(PMError *error) {
                                          NSAssert(error, @"Error message not implemented!");
                                          NSLog(@"Preathorization with method failure. PMError type: %i  message: %@", error.type, error.message);
                                          
                                          [progress stopAnimating];
                                          
                                          UIAlertView *preauthoAlert = [[UIAlertView alloc]
                                                                        initWithTitle:[NSString stringWithFormat: @"Generate preauthorization error type: %d", error.type]
                                                                        message:error.message
                                                                        delegate:nil
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil];
                                          [preauthoAlert show];
                                      }];
    }

}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
	
	if (pickerView == self.monthPickerView)
	{
        returnStr = [self.pickerMonthArray objectAtIndex:row];
	}
    else    //yearPickerView
    {
        returnStr = [self.pickerYearArray objectAtIndex:row];
    }

	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
  
    return screenRect.size.width-20;    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return (pickerView == self.monthPickerView)?[self.pickerMonthArray count] : [self.pickerYearArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    editedField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"TextField: %@, tag = %d", textField.text, textField.tag);
    
    switch (textField.tag) {
        case 10:    //sec: 1, row: 0
            fnameStr = textField.text;
            nameStr = [NSString stringWithFormat:@"%@ %@", fnameStr, lnameStr];
            break;
        case 11:    //sec: 1, row: 1
            lnameStr = textField.text;
            nameStr = [NSString stringWithFormat:@"%@ %@", fnameStr, lnameStr];
            break;
            
        case 20:    //sec: 2, row: 0
            accountStr = textField.text;
            break;
        case 21:    //sec: 2, row: 1
            codeStr = textField.text;
            break;
            
        case 30:    //sec: 3, row: 0
            expMonthStr = textField.text;
            break;
        case 31:    //sec: 3, row: 1
            expYearStr = textField.text;
            break;
            
        default:
            break;
    }
}

-(BOOL)luhnCheck:(NSString*)stringToTest
{
	BOOL isOdd = YES;
	int oddSum = 0;
	int evenSum = 0;
    
	for (int i = [stringToTest length] - 1; i >= 0; i--)
    {
        NSRange r = {i, 1};
        int digit = [[stringToTest substringWithRange:r] intValue];
                
		if (isOdd)
			oddSum += digit;
		else
			evenSum += digit/5 + (2*digit) % 10;
        
		isOdd = !isOdd;
	}
    
	return ((oddSum + evenSum) % 10 == 0);
}

-(void)returnToInitView
{
    UIScreen *screen  = [UIScreen mainScreen];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[screen bounds]];
    window.screen = screen;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:self.mainmenuStoryboardName bundle:nil];
    id mainmenuViewController = [storyboard instantiateViewControllerWithIdentifier:self.mainmenuViewControllerName];
    window.rootViewController = mainmenuViewController;
    
    [self.navigationController pushViewController:mainmenuViewController animated:YES];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"Will rotate");    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 30)
    {
        textField.inputView = self.monthPickerView;
    }
    if (textField.tag == 31)
    {
        textField.inputView = self.yearPickerView;
    }
    
    
    textField.inputView.hidden = false;

    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField.tag == 30)
        textField.text = [self.pickerMonthArray objectAtIndex:[self.monthPickerView selectedRowInComponent:0]];
    if(textField.tag == 31)
        textField.text = [self.pickerYearArray objectAtIndex:[self.yearPickerView selectedRowInComponent:0]];
    
    return YES;
}

@end
