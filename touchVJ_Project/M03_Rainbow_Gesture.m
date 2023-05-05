
#import "M03_Rainbow.h"

@implementation M03_Rainbow (GESTURE)
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM
{
    TAP_Center[NUM][0] = *tapX_ptr;
    TAP_Center[NUM][1] = (*tapY_ptr)*0.75;
    
    TAP_Alpha[NUM] = 1.0f;
    TAP_sizeDist[NUM] = 0.2 + random()%100 * 0.005;
    TAP_actSize[NUM] = 0.0f;
}

- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM
{
    int i;
    
    GLfloat centerX = *LPress_X_ptr;
    GLfloat centerY = (*LPress_Y_ptr)*0.75;
    GLfloat radianShift = (random()%100)*0.01*M_PI;
    
    if(!isLongPressed[LPress_INDEX])
    {
        isLongPressed[LPress_INDEX] = YES;
        
        LP_Center_Origin[LPress_INDEX][0] = centerX;
        LP_Center_Origin[LPress_INDEX][1] = centerY;
    
        GLfloat randomVelocity = (random()%100 * 0.0004) + 0.01f; // 0.01 - 0.05
        
        for( i = 0 ; i < M03_LP_CONDITION ; i++ )
        {
            float radian = ((float)i / (float)M03_LP_CONDITION) * M_PI * 2.0f;
        
            LP_Center[LPress_INDEX][i][0] = centerX;
            LP_Center[LPress_INDEX][i][1] = centerY;
        
            LP_Center_Velocity[LPress_INDEX][i][0] = cosf(radian+radianShift) * randomVelocity;
            LP_Center_Velocity[LPress_INDEX][i][1] = sinf(radian+radianShift) * randomVelocity;
        }
        
        Byte tempIndex = random()%M03_HUE_CONDITION;
        
        for( i = 0 ; i < M03_LP_CONDITION ; i++ )
        {
            LP_ColorINDEX[LPress_INDEX][i] = tempIndex;
            tempIndex++;
            if(tempIndex >= M03_HUE_CONDITION )
            {
                tempIndex = 0;
            }
        }
        
    }// if
}

- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM
{
    isPanned = YES;
    
    CURRENT_PAN_NUM = NUM;
    
    GLfloat* ptr = Value_ptr;
    GLfloat panVec[2];
    
    GLfloat posX = *ptr;
    ptr++;
    GLfloat posY = (*ptr)*0.75;
    ptr++;
    GLfloat transX = *ptr;
    ptr++;
    GLfloat transY = *ptr;
    ptr++;
    panVec[0] = (*ptr)*3.0f;
    ptr++;
    panVec[1] = (*ptr)*3.0f;
    ptr++;
    //GLfloat velocity = *ptr;
    
    tangentVec[CURRENT_PAN_NUM][0] = panVec[0];
    tangentVec[CURRENT_PAN_NUM][1] = panVec[1];
    
    basePoint[CURRENT_PAN_NUM][0] = posX;
    basePoint[CURRENT_PAN_NUM][1] = posY;
    
    cross_A[CURRENT_PAN_NUM][0] = -panVec[1];
    cross_A[CURRENT_PAN_NUM][1] = panVec[0];
    
    cross_B[CURRENT_PAN_NUM][0] = panVec[1];
    cross_B[CURRENT_PAN_NUM][1] = -panVec[0];
    
    GLfloat crossNorm;
    
    crossNorm = 0.02 / sqrt(cross_A[CURRENT_PAN_NUM][0]*cross_A[CURRENT_PAN_NUM][0] + cross_A[CURRENT_PAN_NUM][1]*cross_A[CURRENT_PAN_NUM][1]);
    
    cross_A[CURRENT_PAN_NUM][0] *= crossNorm;
    cross_A[CURRENT_PAN_NUM][1] *= crossNorm;
    cross_B[CURRENT_PAN_NUM][0] *= crossNorm;
    cross_B[CURRENT_PAN_NUM][1] *= crossNorm;
    
    Rainbow_Counter[CURRENT_PAN_NUM] = -2.0f;
    
    
    
    dist_trans[0] = transX - prev_trans[0];
    dist_trans[1] = transY - prev_trans[1];
    
}
- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM
{
    isPinched = YES;
    
    GLfloat* tempPtr = Center_ptr;
    
    GLfloat centerX = *tempPtr; tempPtr++;
    GLfloat centerY = *tempPtr * 0.75f;
    GLfloat radius = *Radius_ptr;
    GLfloat scale = *Scale_ptr;
    
    pinch_centerX = centerX;
    pinch_centerY = centerY;
    pinch_radius = radius;
    pinch_scale = scale;
    
    if( isFirstPinch == YES )
    {
        int i;
        isFirstPinch = NO;
        act_pinch_centerX = centerX;
        act_pinch_centerY = centerY;
        
        for( i = 0 ; i < M03_HUE_CONDITION ; i++ )
        {
            pinchPoint_base[i][0] = centerX;
            pinchPoint_base[i][1] = centerY;
        }
    }
}

- (void)stopLongPress:(Byte)index
{
    isLongPressed[index] = NO;
}
- (void)stopPan
{
    isPanned = NO;
    
    prev_trans[0] = prev_trans[1] = 0.0f;
}
- (void)stopPinch
{
    isPinched = NO;
    isFirstPinch = YES;
}
@end