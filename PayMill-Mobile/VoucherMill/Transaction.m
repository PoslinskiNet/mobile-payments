//
//  Transaction.m
//  VoucherMill
//
//  Created by PayMill on 3/7/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import "Transaction.h"


@implementation Transaction

@dynamic amount;
@dynamic origin_amount;
@dynamic status;
@dynamic descr;
@dynamic responce;
@dynamic payment;
@dynamic relationship;

@end

@implementation SavedTransaction

@synthesize transactionID;
@synthesize transactionType;
@synthesize voucherType;

@end