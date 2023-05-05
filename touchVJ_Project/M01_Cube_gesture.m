#import "M01_Cube.h"

@implementation M01_Cube ( GESTURE )
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM
{
    int i;
    GLfloat xpos = (*tapX_ptr)*viewSizeRatio;
    GLfloat ypos = (*tapY_ptr)*0.75*viewSizeRatio;
    
    GLfloat unitX[3];
    GLfloat unitY[3];
    GLfloat unitZ[3];

    unitX[0] = lookAtMat[0];    unitX[1] = lookAtMat[4];    unitX[2] = lookAtMat[8];
    unitY[0] = lookAtMat[1];    unitY[1] = lookAtMat[5];    unitY[2] = lookAtMat[9];
    unitZ[0] = lookAtMat[2];    unitZ[1] = lookAtMat[6];    unitZ[2] = lookAtMat[10];
    
    GLfloat SHIFT[3];
    
    SHIFT[0] = (-unitZ[0]) + xpos*unitX[0] + ypos*unitY[0];
    SHIFT[1] = (-unitZ[1]) + xpos*unitX[1] + ypos*unitY[1];
    SHIFT[2] = (1.0-unitZ[2]) + xpos*unitX[2] + ypos*unitY[2];
    
    
    for( i = 0 ; i < 10 ; i++ )
    {
        if( ctl_INDEX >= NUM_CUBE - 80 ) // 0 - 219
        { ctl_INDEX = 0; }
        
        ctlPoint[ctl_INDEX][0] = SHIFT[0];
        ctlPoint[ctl_INDEX][1] = SHIFT[1];   
        ctlPoint[ctl_INDEX][2] = SHIFT[2];
        
        ctlPoint_dist[ctl_INDEX][0] = ctlPoint[ctl_INDEX][0] + (random()%200 - 100)*0.005;
        ctlPoint_dist[ctl_INDEX][1] = ctlPoint[ctl_INDEX][1] + (random()%200 - 100)*0.005;
        ctlPoint_dist[ctl_INDEX][2] = ctlPoint[ctl_INDEX][2] + (random()%200 - 100)*0.005;
        
        ctlColor[ctl_INDEX][3] = 1.0f;
        
        act_cubeSize[ctl_INDEX] = (random()%100)*0.02;
        cubeSize_dist[ctl_INDEX] = (random()%100)*0.025;
        
        ctl_INDEX++;
        
    }
}

- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM
{
    int i;
    
    GLfloat xpos = (*LPress_X_ptr)*viewSizeRatio;
    GLfloat ypos = (*LPress_Y_ptr)*viewSizeRatio*0.75;

    GLfloat unitX[3];
    GLfloat unitY[3];
    GLfloat unitZ[3];
    
    unitX[0] = lookAtMat[0];    unitX[1] = lookAtMat[4];    unitX[2] = lookAtMat[8];
    unitY[0] = lookAtMat[1];    unitY[1] = lookAtMat[5];    unitY[2] = lookAtMat[9];
    unitZ[0] = lookAtMat[2];    unitZ[1] = lookAtMat[6];    unitZ[2] = lookAtMat[10];
    
    GLfloat SHIFT[3];
    
    SHIFT[0] = (-unitZ[0]) + xpos*unitX[0] + ypos*unitY[0];
    SHIFT[1] = (-unitZ[1]) + xpos*unitX[1] + ypos*unitY[1];
    SHIFT[2] = (1.0-unitZ[2]) + xpos*unitX[2] + ypos*unitY[2];

    if( isLongPressed[LPress_INDEX] == NO )
    {
        short i_Start = NUM_CUBE - (80 - 20*LPress_INDEX);
        GLfloat RADIUS;
        
        for( i = i_Start ; i < i_Start+20 ; i++ )
        {
            ctlPoint[i][0] = ctlPoint_dist_stock[i][0] = SHIFT[0];
            ctlPoint[i][1] = ctlPoint_dist_stock[i][1] = SHIFT[1];
            ctlPoint[i][2] = ctlPoint_dist_stock[i][2] = SHIFT[2];
            
            
            RADIUS = random()%100 * 0.005 + 0.01;
            
            GLfloat sphereX = (random()%200-100)* 0.005;
            GLfloat sphereY = (random()%200-100)* 0.005;
            GLfloat sphereZ = (random()%200-100)* 0.005;
            GLfloat pos_nega;
            if( random()%2 == 0 ){ pos_nega = 1.0f; }
            else{ pos_nega = -1.0f; }
            
            GLfloat lengthWeight = RADIUS / sqrtf( sphereX*sphereX + sphereY*sphereY + sphereZ*sphereZ ) * pos_nega;
            
            ctlPoint_dist[i][0] = ctlPoint[i][0] + sphereX * lengthWeight;
            ctlPoint_dist[i][1] = ctlPoint[i][1] + sphereY * lengthWeight;
            ctlPoint_dist[i][2] = ctlPoint[i][2] + sphereZ * lengthWeight;
            
            ctlColor[i][3] = 1.0f;
            
            act_cubeSize[i] = 0.0f;
            cubeSize_dist[i] = (random()%100)*0.03;
        }// for i
        
        isLongPressed[LPress_INDEX] = YES;
        
    }// if YES
}

- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM
{
    GLfloat* ptr = Value_ptr;
    
    //GLfloat posX = *ptr;
    ptr++;
    //GLfloat posY = *ptr;
    ptr++;
    GLfloat transX = *ptr;
    ptr++;
    GLfloat transY = *ptr;
    ptr++;
   // GLfloat vecX = *ptr;
    ptr++;
    //GLfloat vecY = *ptr;
    ptr++;
    //GLfloat velocity = *ptr;
    
    World_Translate[0] = ( transX - Pan_Translate_Stock[0] );
    World_Translate[1] = ( transY - Pan_Translate_Stock[1] );
    
    Pan_Translate_Stock[0] = transX;
    Pan_Translate_Stock[1] = transY;
    
    
    isPanned = YES;
}

- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM
{
    GLfloat* Cptr = Center_ptr;
    GLfloat center_x = (*Cptr)*viewSizeRatio;
    Cptr++;
    GLfloat center_y = (*Cptr)*0.75*viewSizeRatio;
    //GLfloat radius = *Radius_ptr;
    GLfloat scale = *Scale_ptr;
    //GLfloat velocity = *Vel_ptr;
    
    
    GLfloat scaleValue;
    
    if (scale > 1.0f)
    {
        if( scale > 6.0f )
        {scale = 6.0f;}
        scaleValue = (scale-1.0f)*10.0f;
    }
    else
    {
        scaleValue = ( scale-1.0f )*40.0f;
    }
    
    // fovy is 50.0 - 140.0
    fovy = 90.0f - scaleValue;
    
    ViewX = center_x;
    ViewY = center_y;
    
    isPinched = YES;
}

- (void)stopLongPress:(Byte)index
{
    int i;
    short i_Start = NUM_CUBE - (80 - 20*index);
    
    isLongPressed[index] = NO;
    
    for( i = i_Start ; i < i_Start+20 ; i++ )
    {
        ctlPoint_dist[i][0] = ctlPoint_dist_stock[i][0];
        ctlPoint_dist[i][1] = ctlPoint_dist_stock[i][1];
        ctlPoint_dist[i][2] = ctlPoint_dist_stock[i][2];
        cubeSize_dist[i] = 0.0f;
    }
}   

- (void)stopPan
{
    isPanned = NO;
    
    World_Translate[0] = 0.0f;
    World_Translate[1] = 0.0f;
    
    Pan_Translate_Stock[0] = 0.0f;
    Pan_Translate_Stock[1] = 0.0f;
}

- (void)stopPinch
{
    isPinched = NO;
    
    ViewX = 0.0f;
    ViewY = 0.0f;
    fovy = 90.0f;
}

@end