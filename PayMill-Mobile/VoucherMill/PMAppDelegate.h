//
//  PMAppDelegate.h
//  VoucherMill
//
//  Created by PayMill on 1/22/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMPaymentDetailsViewController;

UINavigationController *navigationController;

@interface PMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) PMPaymentDetailsViewController *pmViewController;
@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic) bool isPreuthorization;
@property (nonatomic) int voucherValue;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end
