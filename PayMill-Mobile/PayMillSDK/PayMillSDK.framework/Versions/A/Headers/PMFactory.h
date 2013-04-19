//
//  PMFactory.h
//  PayMillSDK
//
//  Created by PayMill on 3/1/13.
//  Copyright (c) 2013 PayMill. All rights reserved.
//
#import "PMPaymentMethod.h"
#import "PMPaymentParams.h"
#import "PMError.h"
/**
 Use only this factory class to create a PMPaymentMethod and PMPaymentParams.
 */
@interface PMFactory : NSObject
/**
 Generates a PaymentMethod from credit card details.
 @param accHolder credit card account holder
 @param cardNumber credit card number
 @param expiryMonth credit card expiry month
 @param expiryYear credit card expirty year
 @param verification credit card verfication number
 @param error PMError object
 @return PMPaymentMethod successfully created object
 */
+ (id<PMPaymentMethod>)genCardPaymentWithAccHolder:(NSString*)accHolder cardNumber:(NSString*)cardNumber expiryMonth:(NSString*) expiryMonth expiryYear:(NSString*)expiryYear verification:(NSString*)verification error:(PMError **)error;
/**
 Generates a PaymentMethod from direct debit payment details.
 @param accountNumber account number
 @param accountBank	bank code
 @param accountHolder first and second name of the account holder
 @param accountCountry	ISO 3166-2 formatted country code
 @param error PMError object
 @return PMPaymentMethod successfully created object
 */
+ (id<PMPaymentMethod>)genNationalPaymentWithAccNumber:(NSString *)accountNumber accBank:(NSString *)accountBank accHolder:(NSString *)accountHolder accCountry:(NSString *)accountCountry error:(PMError **)error;
/**
 Use this method to generate the PaymentParams object, needed for creating transactions, preauthorizations and tokens.
 @param currency Three character ISO 4217 formatted currency code.
 @param amount amount (in cents) which will be charged
 @param description	a short description for the transaction (e.g. shopping cart ID) or empty string or null.
 Note: You don't need to supply a description parameter when generating a token
 @param error PMError object
 @return PMPaymentParams successfully created object
 */
+ (PMPaymentParams*)genPaymentParamsWithCurrency:(NSString*)currency amount:(int)amount description:(NSString*)description error:(PMError **)error;
@end
