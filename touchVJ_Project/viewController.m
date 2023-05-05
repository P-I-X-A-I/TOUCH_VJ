//
//  viewController.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "viewController.h"


@implementation viewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations    
        return YES;
}

//***** one step method

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    dispLink.paused = YES;
    
    CGPoint drawView_Origin;
    CGPoint GUIView_1_Origin;
    CGPoint GUIView_2_Origin;
    CGPoint SegmentBar_Origin;
    CGPoint SegmentView_Origin;
    
    if( toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
    {
        BG_Image_View.frame = CGRectMake(0.0f, 0.0f, 768.0f, 1024.0f);
        BG_Image_View.image = [UIImage imageNamed:@"BG_Portrait.png"];
        drawView_Origin = CGPointMake(384.0, 764.0); // 640,480
        GUIView_1_Origin = CGPointMake(219.0, 141.0);
        GUIView_2_Origin = CGPointMake(219.0, 386.0);
        SegmentBar_Origin = CGPointMake(544.0, 36.0);
        SegmentView_Origin = CGPointMake(544.0, 286.0);
    }
    else
    {
        BG_Image_View.frame = CGRectMake(0.0f, 0.0f, 1024.0f, 768.0f);
        BG_Image_View.image = [UIImage imageNamed:@"BG_Landscape.png"];
        drawView_Origin = CGPointMake(345.0, 508.0); //640 480
        GUIView_1_Origin = CGPointMake(180.0, 135.0);
        GUIView_2_Origin = CGPointMake(510.0, 135.0);
        SegmentBar_Origin = CGPointMake(839.0, 283.0);
        SegmentView_Origin = CGPointMake(839.0,528.0);
    }

    
    [UIView beginAnimations:@"viewLayoutChange" context:NULL];
    [UIView setAnimationDuration:0.4];
    
    drawView.center = drawView_Origin;
    GUI_View_1.center = GUIView_1_Origin;
    GUI_View_2.center = GUIView_2_Origin;
    Segment_Bar.center = SegmentBar_Origin;
    Segment_View.center = SegmentView_Origin;
    
    [UIView commitAnimations];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"willAnimateRotation to %d duration %f", toInterfaceOrientation, duration);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    dispLink.paused = NO;
    NSLog(@"didRotateFrom %d", fromInterfaceOrientation);
}


// **** two step animation Method
//- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    NSLog(@"First Half animation to %d duration %f", toInterfaceOrientation, duration);
//}
//
//- (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    NSLog(@"did First half of to %d", toInterfaceOrientation);
//}
//
//- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    NSLog(@"Second animation from %d duration %f", fromInterfaceOrientation, duration);
//}

- (void)setPtrToDisplayLink:(CADisplayLink*)disp
{
    dispLink = disp;
}


@end
