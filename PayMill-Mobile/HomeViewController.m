//
//  HomeViewController.m
//  CoreDataEx
//
//  Created by Anil Jagtap on 21/01/13.
//  Copyright (c) 2013 Anil Jagtap. All rights reserved.
//

#import "HomeViewController.h"
//#import "AppDelegate.h"
#import "PMAppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize txtName, txtPhone;
@synthesize myTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableData = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if( cell == nil ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
}

- (IBAction)btnSaveClick:(id)sender {
    [txtName resignFirstResponder];
    [txtPhone resignFirstResponder];
    
    NSString *name = txtName.text;
    NSString *phone = txtPhone.text;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSManagedObject *record = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
    
    [record setValue:name forKey:@"name"];
    [record setValue:phone forKey:@"phone"];
    NSError *err;
    
    if( ! [context save:&err] ){
        NSLog(@"Cannot save data: %@", [err localizedDescription]);
    }
}

- (IBAction)btnLoadData:(id)sender {
    [tableData removeAllObjects]; // Remove all previous objects to avoid duplication
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for( NSManagedObject *info in fetchedObjects){
        [tableData addObject: [info valueForKey:@"name"]];
    }
    
    [myTable reloadData];
}
@end
