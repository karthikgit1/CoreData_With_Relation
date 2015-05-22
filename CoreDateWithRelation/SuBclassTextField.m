//
//  SuBclassTextField.m
//  CoreDateWithRelation
//
//  Created by Vy Systems - iOS1 on 1/23/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import "SuBclassTextField.h"

@implementation SuBclassTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset( bounds, 10 , 0);
    
   
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset( bounds, 10 , 0);
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
   // self.borderStyle = UITextBorderStyleNone;
    
//    CALayer *leftBorder = [CALayer layer];
//    leftBorder.borderColor = [UIColor redColor].CGColor;
//    leftBorder.borderWidth = 1;
//    
//    NSLog(@"height is %f",self.frame.size.height);
//    
//    leftBorder.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height+2);
//   // leftBorder.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    
//    [self.layer addSublayer:leftBorder];
    
    return self;
}

@end
