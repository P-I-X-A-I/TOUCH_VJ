//
//  glesView.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "glesView.h"


@implementation glesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (Class)layerClass
{
    NSLog(@"layerClass");
    return [CAEAGLLayer class];
}

- (void)dealloc
{
    [super dealloc];
}

@end
