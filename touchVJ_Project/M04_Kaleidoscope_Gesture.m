
#import "M04_Kaleidoscope.h"

@implementation M04_Kaleidoscope ( GESTURE )

- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM
{
    GLfloat tap_X = *tapX_ptr*viewSizeRatio;
    GLfloat tap_Y = (*tapY_ptr)*0.75*viewSizeRatio;
    
    // tap center
    tapCenter[TAP_COUNTER][2] = (random()%80-50)*0.01f;
    
    GLfloat depthWeight = 1.0 - tapCenter[TAP_COUNTER][2];
    
    tap_X *= depthWeight;
    tap_Y *= depthWeight;
    
    tapCenter[TAP_COUNTER][0] = tap_X*cosf(-act_lookingAxis[0]) - tap_Y*sinf(-act_lookingAxis[0]) + act_lookingAxis[0];
    tapCenter[TAP_COUNTER][1] = tap_X*sinf(-act_lookingAxis[0]) + tap_Y*cosf(-act_lookingAxis[0]) + act_lookingAxis[1];
    tapCenter_Vel[TAP_COUNTER][0] = 0.0f;
    tapCenter_Vel[TAP_COUNTER][1] = 0.0f;
    tapCenter_Vel[TAP_COUNTER][2] = 0.01f;
    
    // isTapDraw
        isTapDraw[TAP_COUNTER] = YES;
        TAP_DRAW_COUNTER[TAP_COUNTER] = 0;
    
    TAP_COUNTER++;
    if (TAP_COUNTER == M04_TAP_NUM)
    {
        TAP_COUNTER = 0;
    }
    
    
    tap_accel = 0.05f;
    
}
- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM
{
    int i, j;
    
    if( isLongPressed[LPress_INDEX] == NO )
    {
        isLongPressed[LPress_INDEX] = YES;
    
        GLfloat LP_X = (*LPress_X_ptr)*viewSizeRatio;
        GLfloat LP_Y = (*LPress_Y_ptr)*0.75*viewSizeRatio;
    
        LP_Center[LPress_INDEX][2] = (random()%35) * 0.01;
    
        GLfloat depthWeight = 1.0 - LP_Center[LPress_INDEX][2];
        
        LP_X *= depthWeight;
        LP_Y *= depthWeight;
        
        LP_Center[LPress_INDEX][0] = LP_X*cosf(-act_lookingAxis[0]) - LP_Y*sinf(-act_lookingAxis[0]) + act_lookingAxis[0];
        LP_Center[LPress_INDEX][1] = LP_X*sinf(-act_lookingAxis[0]) + LP_Y*cosf(-act_lookingAxis[0]) + act_lookingAxis[1];
        
        for( i = 0 ; i < 54 ; i++ )
        {
            for( j = 0 ; j < 3 ; j++ )
            {
                act_LP_Vertex[LPress_INDEX][i][j][0] = LP_Center[LPress_INDEX][0];
                act_LP_Vertex[LPress_INDEX][i][j][1] = LP_Center[LPress_INDEX][1];
                act_LP_Vertex[LPress_INDEX][i][j][2] = LP_Center[LPress_INDEX][2];
                act_LP_Vertex[LPress_INDEX][i][j][3] = 1.0f;
                
                act_LP_velocity[LPress_INDEX][i][j][0] = 0.0f;
                act_LP_velocity[LPress_INDEX][i][j][1] = 0.0f;
                act_LP_velocity[LPress_INDEX][i][j][2] = 0.0f;
            }
        }
        
        act_LP_afterAlpha[LPress_INDEX] = 1.0f;
    
        
        for( i = 0 ; i < 6 ; i++ )
        {
            for( j = 0 ; j < 54 ; j++ )
            {
                for( int k = 0 ; k < 3 ; k++ )
                {
                    act_LP_VStock[i][LPress_INDEX][j][k][0] = 0.0f;
                    act_LP_VStock[i][LPress_INDEX][j][k][1] = 0.0f;
                    act_LP_VStock[i][LPress_INDEX][j][k][2] = 0.0f;
                    act_LP_VStock[i][LPress_INDEX][j][k][3] = 1.0f;
                }
            }
        }
    }// isLongpressed
}
- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM
{

    GLfloat* panPtr = Value_ptr;
    //GLfloat posX = *panPtr;
    panPtr++;
    //GLfloat posY = *panPtr;
    panPtr++;
    //GLfloat transX = *panPtr;
    panPtr++;
    //GLfloat transY = *panPtr;
    panPtr++;
    GLfloat vecX = *panPtr;
    panPtr++;
    GLfloat vecY = *panPtr;
    panPtr++;
    //GLfloat velocity = *panPtr;
    
    
    act_PanF[0] = vecX*0.0012f;
    act_PanF[1] = vecY*0.0012f;
}


- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM
{
    isPinched = YES;
    
    GLfloat* cPtr = Center_ptr;
    GLfloat center[2];
    GLfloat radius;
    GLfloat scale;
    
    center[0] = *cPtr;  cPtr++;
    center[1] = (*cPtr)*0.75;
    radius = *Radius_ptr;
    scale = *Scale_ptr;
    
    lookingAxis[0] = center[0]*0.2;
    lookingAxis[1] = center[1]*0.2;
    
    if(scale < 1.0f)
    {
        fovy_angle = 90.0f + (1.0f-scale)*20.0f;
    }
    else
    {
        if(scale > 2.0f)
        { scale = 2.0f;}
        
        fovy_angle = 90.0f - scale * 10.0f;
    }
    
    texScale = scale;
}

- (void)stopLongPress:(Byte)index
{
    isLongPressed[index] = NO;
}
- (void)stopPan
{

}
- (void)stopPinch
{
    isPinched = NO;
    lookingAxis[0] = 0.0f;
    lookingAxis[1] = 0.0f;
    
    fovy_angle = 90.0f;
}

@end