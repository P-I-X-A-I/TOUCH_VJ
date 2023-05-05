//
//  viewController.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "glesView.h"

@interface viewController : UIViewController {
    
    IBOutlet glesView* drawView;
    IBOutlet UIView* GUI_View_1;
    IBOutlet UIView* GUI_View_2;
    IBOutlet UIView* Segment_View;
    IBOutlet UISegmentedControl* Segment_Bar;
    IBOutlet UIImageView* BG_Image_View;
    
    CADisplayLink* dispLink;
    
}

- (void)setPtrToDisplayLink:(CADisplayLink*)disp;

@end
