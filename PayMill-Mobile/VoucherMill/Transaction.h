//
//  Transaction.h
//  VoucherMill
//
//  Created by PayMill on 3/7/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSString * amount;
@property (nonatomic, retain) NSString * origin_amount;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * responce;
@property (nonatomic, retain) NSString * payment;
@property (nonatomic, retain) NSManagedObject *relationship;

@end

@interface SavedTransaction : NSManagedObject

@property (nonatomic, retain) NSString *transactionID;
@property (nonatomic, retain) NSString *transactionType;
@property (nonatomic, retain) NSString *voucherType;

@end