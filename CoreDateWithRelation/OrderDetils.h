//
//  OrderDetils.h
//  CoreDateWithRelation
//
//  Created by Vy Systems - iOS1 on 1/23/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Order;

@interface OrderDetils : NSManagedObject

@property (nonatomic, retain) NSString * orderid;
@property (nonatomic, retain) NSString * productid;
@property (nonatomic, retain) NSString * productname;
@property (nonatomic, retain) Order *orderrelation;

@end
