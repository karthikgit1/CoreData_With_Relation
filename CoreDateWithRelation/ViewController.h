//
//  ViewController.h
//  CoreDateWithRelation
//
//  Created by Vy Systems - iOS1 on 1/22/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
@interface ViewController : UIViewController
//---- for network check ---
+(BOOL) networkReachable;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

// Set to YES to get some debugging output in the console.
@property BOOL debug;
+ (id)sharedManager;
+(char *)getData;

- (NSFetchedResultsController *)getCartProductDetails;
- (NSFetchedResultsController *)getCartProductDetails:(NSString *)_orderID :(NSString *)_entityName;


-(void)getTotalPrice;

@property (nonatomic,assign) float totalPrice;




@end

