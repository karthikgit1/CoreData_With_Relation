//
//  Order.h
//  CoreDateWithRelation
//
//  Created by Vy Systems - iOS1 on 1/23/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrderDetils;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * orderid;
@property (nonatomic, retain) NSString * total;
@property (nonatomic, retain) NSSet *orderidrelation;
@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addOrderidrelationObject:(OrderDetils *)value;
- (void)removeOrderidrelationObject:(OrderDetils *)value;
- (void)addOrderidrelation:(NSSet *)values;
- (void)removeOrderidrelation:(NSSet *)values;

@end
