//
//  RootViewController.h
//  VoucherMill
//
//  Created by PayMill on 3/7/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PMCoreDataViewController : UITableViewController //<NSFetchedResultsControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
        
    NSMutableArray *tableData;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *tableData;
@property (weak, nonatomic) IBOutlet UITableView *myTable;


-(void)load;
@end
