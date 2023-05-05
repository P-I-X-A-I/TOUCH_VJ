//
//  CustomSlider.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/05/04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomSlider.h"


@implementation CustomSlider

- (void)awakeFromNib
{
    // Custom Slider
    UIImage* SliderThumbImage = [UIImage imageNamed:@"slider_thumb.png"];
    [self setThumbImage:SliderThumbImage forState:UIControlStateNormal];
    [self setThumbImage:SliderThumbImage forState:UIControlStateSelected];
    [self setThumbImage:SliderThumbImage forState:UIControlStateHighlighted];
    
    UIImage* LeftSliderImage = [[UIImage imageNamed:@"slider_left.png"] stretchableImageWithLeftCapWidth:8 topCapHeight:0];
    [self setMinimumTrackImage:LeftSliderImage forState:UIControlStateNormal];
    [self setMinimumTrackImage:LeftSliderImage forState:UIControlStateSelected];
    [self setMinimumTrackImage:LeftSliderImage forState:UIControlStateHighlighted];
    
    UIImage* RightSliderImage = [[UIImage imageNamed:@"slider_right.png"] stretchableImageWithLeftCapWidth:8 topCapHeight:0];
    [self setMaximumTrackImage:RightSliderImage forState:UIControlStateNormal];
    [self setMaximumTrackImage:RightSliderImage forState:UIControlStateSelected];
    [self setMaximumTrackImage:RightSliderImage forState:UIControlStateHighlighted];
}

@end
