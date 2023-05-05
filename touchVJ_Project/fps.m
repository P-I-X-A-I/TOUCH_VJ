
#import "mainController.h"

@implementation mainController ( FPS )

- (IBAction)segment_FPS:(UISegmentedControl *)sender
{
    NSLog(@"segment FPS %d", sender.selectedSegmentIndex );
    
    if( sender.selectedSegmentIndex == 1 )
    {
        isFPS_60 = YES;
    }
    else
    {
        isFPS_60 = NO;
    }
}

@end