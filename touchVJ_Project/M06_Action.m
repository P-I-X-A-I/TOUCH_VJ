
#import "M06_Plants.h"

@implementation M06_Plants ( ACTION )

- (IBAction)sliders:(UISlider *)sender
{
    int TAG = sender.tag;
    float VALUE = sender.value;
    
    switch (TAG)
    {
        case 0:// hue
            BG_HSB[CURRENT_SLOT][0] = VALUE;
            break;
        case 1:// saturation
            BG_HSB[CURRENT_SLOT][1] = VALUE;
            break;
        case 2:// brightness
            BG_HSB[CURRENT_SLOT][2] = VALUE;
            break;
    }
}

@end