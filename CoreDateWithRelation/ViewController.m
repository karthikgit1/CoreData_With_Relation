//
//  ViewController.m
//  CoreDateWithRelation
//
//  Created by Vy Systems - iOS1 on 1/22/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import "ViewController.h"
#import "Order.h"
#import "OrderDetils.h"

@interface ViewController ()
{
    AppDelegate *appDelegate ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)add:(id)sender
{
    Order *_order;
    
    OrderDetils * _orddet;
    
    _order =     [NSEntityDescription
                  insertNewObjectForEntityForName:@"Order"
                  inManagedObjectContext:appDelegate.managedObjectContext];
    
    NSString *_oid = @"ord1";
    
    _order.orderid = _oid;
    _order.total   =@"200";
    _order.date = @"tomorrow";
    
    for(int i=0; i<2; i++)
    {
        _orddet =  [NSEntityDescription
                    insertNewObjectForEntityForName:@"OrderDetils"
                    inManagedObjectContext:appDelegate.managedObjectContext];
        if(i==0)
        {
            _orddet.orderid = _oid;
            _orddet.productid = [NSString stringWithFormat:@"%d",i];
            _orddet.productname = @"11";
        }
        else
        {
            _orddet.orderid = _oid;
            _orddet.productid = [NSString stringWithFormat:@"%d",i];
            _orddet.productname = @"22";

            
        }
        
        [_order addOrderidrelationObject:_orddet];
        [_orddet setOrderrelation:_order];
        
    }
    
    [appDelegate.managedObjectContext save:nil];

}

- (IBAction)update:(id)sender
{
    NSString * _prdid = @"0";
    NSString *_oid = @"ord2";
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"OrderDetils"];
    
   // NSPredicate *predicate=[NSPredicate predicateWithFormat:@"productid==%@ AND orderid==%@",_prdid,_oid];
     NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderid==%@",_oid];
    
    fetchRequest.predicate=predicate;
    
    NSError *error;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    int ctr = 121;
    for (OrderDetils *_updateorderdetail in fetchedObjects)
    {
        if (_updateorderdetail != nil)
        {
            _updateorderdetail.productid=[NSString stringWithFormat:@"%d",ctr + 1];
            
            [appDelegate.managedObjectContext save:nil];
            
        }
        else
        {
            NSLog(@"Orderdetails not found");
        }
    }
    
  
}

- (IBAction)delete:(id)sender
{

    
    //*******Delete Order ID **********//
    
    NSString * _oid = @"ord2";
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Order"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderid==%@",_oid]; // If required to fetch specific vehicle
    fetchRequest.predicate=predicate;
    
    Order *_deleteorder=[[appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    
    if (_deleteorder != nil)
    {
        [appDelegate.managedObjectContext deleteObject:_deleteorder];
        [appDelegate.managedObjectContext save:nil];
    }
    else
    {
        NSLog(@"Order not found");
    }
        
    
    
    //**********Delete OrderDetails****************//
    /*
    NSString * _prdid = @"10";
    NSString *_oid = @"ord2";
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"OrderDetils"];
    
   NSPredicate *predicate=[NSPredicate predicateWithFormat:@"productid==%@ AND orderid==%@",_prdid,_oid]; // If required to fetch specific vehicle
    
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderid==%@",_oid]; // If required to fetch specific vehicle
    
    fetchRequest.predicate=predicate;
    
    NSError *error;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (OrderDetils *_deleteorderdetail in fetchedObjects)
    {
       
        if (_deleteorderdetail != nil)
        {
            [appDelegate.managedObjectContext deleteObject:_deleteorderdetail];
            [appDelegate.managedObjectContext save:nil];
            
        }
        else
        {
            NSLog(@"Orderdetails not found");
        }
    }
    
   */
}

- (IBAction)show:(id)sender
{
   
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:appDelegate. managedObjectContext];
    
       [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *info in fetchedObjects)
    {
        NSLog(@"Main Orderid %@", [info valueForKey:@"orderid"]);
        NSSet *ns = [info valueForKey:@"orderidrelation"];
        
        
        NSArray *albumArray = [ns  allObjects];
        
        for (OrderDetils *_od in albumArray)
        {
            NSLog(@"prodid is %@ orderid is %@",_od.productid,_od.orderid);
        }
        
    }
    
    
    //******Show Order Details******//
/*
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"OrderDetils" inManagedObjectContext:appDelegate. managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *info in fetchedObjects)
    {
        NSLog(@"Main Orderid %@", [info valueForKey:@"orderid"]);
        
    }
*/

}

- (IBAction)deleteAll:(id)sender
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items)
    {
        [appDelegate.managedObjectContext deleteObject:managedObject];
    }
    if (![appDelegate.managedObjectContext save:&error])
    {
        
    }
}


#pragma mark - Get Values From CoreData
- (NSFetchedResultsController *)getCartProductDetails:(NSString *)_orderID :(NSString *)_entityName
{
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // 1 - Decide what Entity you want
    //NSString *entityName = @"CartEntity"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", _entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:_entityName];
    
    // 3 - Filter it if you want
    if(![_orderID  isEqual: @""])
    {
        request.predicate = [NSPredicate predicateWithFormat:@"orderid = %@",_orderID];
    }
    //request.predicate = [NSPredicate predicateWithFormat:@"Role.name = Blah"];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"orderid"                                     ascending:NO                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:appDelegate.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
    
    [self performFetch];
    
    NSLog(@"Number of rows %lu",(unsigned long)[[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects]);
    
    return self.fetchedResultsController;
}

- (NSFetchedResultsController *)getCartProductDetails
{
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // 1 - Decide what Entity you want
    NSString *entityName = @"CartEntity"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    
    //request.predicate = [NSPredicate predicateWithFormat:@"Role.name = Blah"];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"productid"                                     ascending:NO                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:appDelegate.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
    
    [self performFetch];
    
    NSLog(@"Number of rows %lu",(unsigned long)[[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects]);
    
    return self.fetchedResultsController;
}


- (void)performFetch
{
    if (self.fetchedResultsController)
    {
        if (self.fetchedResultsController.fetchRequest.predicate)
        {
            if (self.debug) NSLog(@"[%@ %@] fetching %@ with predicate: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchedResultsController.fetchRequest.entityName, self.fetchedResultsController.fetchRequest.predicate);
        }
        else
        {
            if (self.debug) NSLog(@"[%@ %@] fetching all %@ (i.e., no predicate)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchedResultsController.fetchRequest.entityName);
        }
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        if (error) NSLog(@"[%@ %@] %@ (%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription], [error localizedFailureReason]);
    }
    else
    {
        if (self.debug) NSLog(@"[%@ %@] no NSFetchedResultsController (yet?)", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    }
    
}



@end
