//
//  titleAndStoreViewController.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/05/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "titleAndStoreViewController.h"


@implementation titleAndStoreViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if( interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"store and title view rotate");
    dispLink.paused = YES;
}

@end
