

#import "M06_Plants.h"

@implementation M06_Plants ( INIT_VALUES )

- (void)initializeValues
{
    int i, j, k;
    
    for( i = 0 ; i < 5 ; i++ )
    {
        BG_radian[i] = (random()%200)*0.01*M_PI;
        BG_radian_speed[i] = ( random()%200 )*0.00005 + 0.0025;
    }
    
    for( i = 0 ; i < M06_SLOT ; i++ )
    {
        BG_HSB[i][0] = 0.0f;
        BG_HSB[i][1] = 0.0f;
        BG_HSB[i][2] = 1.0f;
    }
    
    act_BG_HSB[0] = 0.0f;
    act_BG_HSB[1] = 0.0f;
    act_BG_HSB[2] = 1.0f;
    
    
    // TAP parameter
    for( i = 0 ; i < 19 ; i++ )
    {
        float radian = (i*20)*0.0174532925;
        
        TAP_CircleBase[i][0] = cosf(radian)*0.1;
        TAP_CircleBase[i][1] = sinf(radian)*0.1;
    }
    
    for( i = 0 ; i < M06_TAP_NUM ; i++ )
    {
        for( j = 0 ; j < 21 ; j++ )
        {
            for( k = 0 ; k < 2 ; k++ )
            {
                TAP_Vertex[i][j][k][0] = 0.0f;
                TAP_Vertex[i][j][k][1] = 0.0f;
                TAP_Vertex[i][j][k][2] = 0.0f;
                TAP_Vertex[i][j][k][3] = 1.0f;
                
                TAP_Color[i][j][k][0] = 1.0f;
                TAP_Color[i][j][k][1] = 1.0f;
                TAP_Color[i][j][k][2] = 1.0f;
                TAP_Color[i][j][k][3] = 1.0f;
            }
        }
        
        TAPED_Center[i][0] = 0.0f;
        TAPED_Center[i][1] = 0.0f;
        TAPED_Center[i][2] = 0.0f;
        
        TAP_COUNTER[i][0] = 0.0f;
        TAP_COUNTER[i][1] = 0.0f;
    }
    
    
    TAP_INDEX = 0;
    
}

@end