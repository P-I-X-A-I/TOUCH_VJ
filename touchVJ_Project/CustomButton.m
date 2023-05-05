//
//  CustomButton.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/05/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomButton.h"


@implementation CustomButton

- (void)awakeFromNib
{
    UIImage* buttonImage = [UIImage imageNamed:@"custom_button.png"];
    UIImage* stretchImage = [buttonImage stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    
    [self setBackgroundImage:stretchImage forState:UIControlStateNormal];
}

@end
