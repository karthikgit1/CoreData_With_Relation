//
//  SecondViewController.m
//  CoreDateWithRelation
//
//  Created by Vy Systems - iOS1 on 1/23/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//



#import "SecondViewController.h"
#import "Order.h"
#import "OrderDetils.h"



const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface SecondViewController ()
{
    AppDelegate *appDelegate ;
    dispatch_queue_t downloadQueue1;
    
    NSManagedObjectContext *_managedObjectContext;
    
    NSOperationQueue *operationQueue;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     downloadQueue1 = dispatch_queue_create("downloader", 0);
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // subscribe to change notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_mocDidSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:_managedObjectContext];
    
    CGFloat topOffset = 0;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [self.view setTintColor:[UIColor blueColor]];
    
    topOffset = ([[UIApplication sharedApplication] statusBarFrame].size.height
                 + self.navigationController.navigationBar.frame.size.height);
#endif
    
    UIColor *floatingLabelColor = [UIColor brownColor];
    
    JVFloatLabeledTextField *titleField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                           CGRectMake(kJVFieldHMargin,
                                                      topOffset,
                                                      self.view.frame.size.width - 2 * kJVFieldHMargin,
                                                      kJVFieldHeight)];
    titleField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Title", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    titleField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    titleField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    titleField.floatingLabelTextColor = floatingLabelColor;
    titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    //    titleField.leftView = leftView;
    //    titleField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:titleField];
    
    UIView *div1 = [UIView new];
    div1.frame = CGRectMake(kJVFieldHMargin, titleField.frame.origin.y + titleField.frame.size.height,
                            self.view.frame.size.width - 2 * kJVFieldHMargin, 1.0f);
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    
    
    //[titleField becomeFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark-Other Functions
-(void)addOrder
{
    
    dispatch_async(downloadQueue1, ^{
        
        [NSThread sleepForTimeInterval:5];
        Order *_order;
        
        OrderDetils * _orddet;
        
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:appDelegate.persistentStoreCoordinator];
        
        NSArray *arr = appDelegate.persistentStoreCoordinator.managedObjectModel.entities;
        
       // NSLog(@"entities are %@",arr);
        
    
        
        
        _order =     [NSEntityDescription
                      insertNewObjectForEntityForName:@"Order"
                      inManagedObjectContext:_managedObjectContext];
        
        NSString *_oid = @"ord3";
        
        _order.orderid = _oid;
        _order.total   =@"400";
        _order.date = @"backgroundthread3";
        
        for(int i=0; i<2; i++)
        {
            _orddet =  [NSEntityDescription
                        insertNewObjectForEntityForName:@"OrderDetils"
                        inManagedObjectContext:_managedObjectContext];
            if(i==0)
            {
                _orddet.orderid = _oid;
                _orddet.productid = [NSString stringWithFormat:@"%d",i];
                _orddet.productname = @"1111";
            }
            else
            {
                _orddet.orderid = _oid;
                _orddet.productid = [NSString stringWithFormat:@"%d",i];
                _orddet.productname = @"1122";
                
                
            }
            
            [_order addOrderidrelationObject:_orddet];
            [_orddet setOrderrelation:_order];
            
        }
        
        [_managedObjectContext save:nil];

        
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self showOrder];
            
        });
        
    });

}

- (void)_mocDidSaveNotification:(NSNotification *)notification
{
    NSManagedObjectContext *savedContext = [notification object];
    
    // ignore change notifications for the main MOC
    if (appDelegate.managedObjectContext == savedContext)
    {
        return;
    }
    
    if (appDelegate.managedObjectContext.persistentStoreCoordinator != savedContext.persistentStoreCoordinator)
    {
        // that's another database
        return;
    }
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [appDelegate.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
    });
}

#pragma mark - IBACTIONS
- (IBAction)addData:(id)sender
{
   // [self addOrder];
    [self addDataNsOperation];
}

- (IBAction)showDetails:(id)sender
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
            NSLog(@"prodid is %@ orderid is %@",_od.productname,_od.orderid);
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

-(void)showOrder
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
            NSLog(@"prodid is %@ orderid is %@",_od.productname,_od.orderid);
        }
        
    }

}

-(void)addDataNsOperation
{
    // Create a new NSOperationQueue instance.
    operationQueue = [NSOperationQueue new];
    
    // Create a new NSOperation object using the NSInvocationOperation subclass.
    // Tell it to run the counterTask method.
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(addorderNsOperation)
                                                                              object:nil];
    // Add the operation to the queue and let it to be executed.
    [operationQueue addOperation:operation];
   
    
//    // The same story as above, just tell here to execute the colorRotatorTask method.
//    operation = [[NSInvocationOperation alloc] initWithTarget:self
//                                                     selector:@selector(colorRotatorTask)
//                                                       object:nil];
//    [operationQueue addOperation:operation];
}

-(void)addorderNsOperation
{
    [NSThread sleepForTimeInterval:5];
    Order *_order;
    
    OrderDetils * _orddet;
    
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:appDelegate.persistentStoreCoordinator];
    
    NSArray *arr = appDelegate.persistentStoreCoordinator.managedObjectModel.entities;
    
    // NSLog(@"entities are %@",arr);
    
    
    
    
    _order =     [NSEntityDescription
                  insertNewObjectForEntityForName:@"Order"
                  inManagedObjectContext:_managedObjectContext];
    
    NSString *_oid = @"ordNsop";
    
    _order.orderid = _oid;
    _order.total   =@"400";
    _order.date = @"backgroundthread3";
    
    for(int i=0; i<2; i++)
    {
        _orddet =  [NSEntityDescription
                    insertNewObjectForEntityForName:@"OrderDetils"
                    inManagedObjectContext:_managedObjectContext];
        if(i==0)
        {
            _orddet.orderid = _oid;
            _orddet.productid = [NSString stringWithFormat:@"%d",i+200];
            _orddet.productname = @"1111";
        }
        else
        {
            _orddet.orderid = _oid;
            _orddet.productid = [NSString stringWithFormat:@"%d",i+200];
            _orddet.productname = @"1122";
            
            
        }
        
        [_order addOrderidrelationObject:_orddet];
        [_orddet setOrderrelation:_order];
        
    }
    
    [_managedObjectContext save:nil];
    

}

@end
