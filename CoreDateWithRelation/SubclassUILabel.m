//
//  SubclassUILabel.m
//  CoreDateWithRelation
//
//  Created by Vy Systems - iOS1 on 1/23/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import "SubclassUILabel.h"

@implementation SubclassUILabel




- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad)
    {
        //To show Styles like Regular, Thin , Italic just have the Fontname-Stylename
        self.font = [UIFont fontWithName:@"Courier New Italic" size:38.f];
        self.textAlignment = NSTextAlignmentRight;
        
        //Border
        self.layer.borderColor = [UIColor brownColor].CGColor;
        self.layer.borderWidth = 1;
        
        //Background Color
        self.backgroundColor = [UIColor redColor];
        
        //Foreground Color
        self.textColor = [UIColor whiteColor];
    }
    else
    {
        //To show Styles like Regular, Thin , Italic just have the Fontname-Stylename
        self.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:12.f];
        self.textAlignment = NSTextAlignmentRight;
        
        //Border
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1;
        
        //Background Color
        self.backgroundColor = [UIColor brownColor];
        
        //Foreground Color
        self.textColor = [UIColor whiteColor];
        
        //Padding Right
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    }
    
    
    return self;
}

@end
