//
//  HomeViewController.h
//  CoreDataEx
//
//  Created by Anil Jagtap on 21/01/13.
//  Copyright (c) 2013 Anil Jagtap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *tableData;
}

@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
- (IBAction)btnSaveClick:(id)sender;
- (IBAction)btnLoadData:(id)sender;

@end
