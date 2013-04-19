//
//  PMPaymentParams.h
//  PayMillSDK
//
//  Created by PayMill on 3/1/13.
//  Copyright (c) 2013 PayMill. All rights reserved.
//
/**
 Object representing the parameters needed to create new Transactions and Preauthorizations. Never extend this interface yourself, instead use the static methods in PMFactory.
 */
@interface PMPaymentParams : NSObject
/**
 Three character ISO 4217 formatted currency code.
 */
@property(nonatomic, strong) NSString *currency;
/**
 amount (in cents) which will be charged
 */
@property(nonatomic) int amount;
/**
 a short description for the transaction (e.g. shopping cart ID) or empty string or null.
 */
@property(nonatomic, strong) NSString *description;
@end
