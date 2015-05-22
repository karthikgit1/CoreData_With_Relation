//
//  SuBclassTextField.h
//  CoreDateWithRelation
//
//  Created by Vy Systems - iOS1 on 1/23/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuBclassTextField : UITextField
- (CGRect)editingRectForBounds:(CGRect)bounds;
- (CGRect)textRectForBounds:(CGRect)bounds;
@end
