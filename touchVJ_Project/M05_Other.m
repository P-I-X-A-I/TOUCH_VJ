
#import "M05_Structure.h"

@implementation M05_Structure ( OTHER )

- (void)culc_Tetra
{
    int a, b;
    
    for( a = 0 ; a < M05_RADIANS ; a++ )
    {
        [self initMatrix];
        
        [self rotate_Xdeg:sinf( rotAxis_Xrad[a] )*360.0f ];
        [self rotate_Ydeg:sinf( rotAxis_Yrad[a] )*360.0f ];
        [self rotate_Zdeg:sinf( rotAxis_Zrad[a] )*360.0f ];
        
        for( b = 0 ; b < 4 ; b++ )
        {
            tetraRot_Vertex[a][b][0] = tetraBase_Vert[b][0];
            tetraRot_Vertex[a][b][1] = tetraBase_Vert[b][1];
            tetraRot_Vertex[a][b][2] = tetraBase_Vert[b][2];
            
            [self culculate_vec3:&tetraRot_Vertex[a][b][0] ];
        }
    }
}



- (IBAction)sliders:(UISlider*)sender
{
    int TAG = sender.tag;
    float VALUE = sender.value;
    
    switch (TAG)
    {
        case 0: // Hue
            Background_Color[CURRENT_SLOT][0] = VALUE;
            break;
        case 1: // Saturation
            Background_Color[CURRENT_SLOT][1] = VALUE;
            break;
        case 2: // Brightness
            Background_Color[CURRENT_SLOT][2] = VALUE;
            break;
        default:
            break;
    }
    
    UIColor* tempColor_1 = [UIColor colorWithHue:Background_Color[CURRENT_SLOT][0]
                                      saturation:Background_Color[CURRENT_SLOT][1]
                                      brightness:Background_Color[CURRENT_SLOT][2] alpha:1.0];
    
    float tempHue = Background_Color[CURRENT_SLOT][0] + 0.12;
    if( tempHue > 1.0 )
    {
        tempHue -= 1.0f;
    }
    
    UIColor* tempColor_2 = [UIColor colorWithHue:tempHue
                                      saturation:Background_Color[CURRENT_SLOT][1]
                                      brightness:Background_Color[CURRENT_SLOT][2] alpha:1.0];

    const CGFloat* component_1 = CGColorGetComponents(tempColor_1.CGColor);
    const CGFloat* component_2 = CGColorGetComponents(tempColor_2.CGColor);
    
    Background_RGB[CURRENT_SLOT][0][0] = *component_1;    component_1++;
    Background_RGB[CURRENT_SLOT][0][1] = *component_1;    component_1++;
    Background_RGB[CURRENT_SLOT][0][2] = *component_1;
    
    Background_RGB[CURRENT_SLOT][1][0] = *component_2;    component_2++;
    Background_RGB[CURRENT_SLOT][1][1] = *component_2;    component_2++;
    Background_RGB[CURRENT_SLOT][1][2] = *component_2;    
}

@end