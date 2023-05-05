
#import "M06_Plants.h"

@implementation M06_Plants ( GESTURE )

- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM
{
    GLfloat tapX = (*tapX_ptr);
    GLfloat tapY = (*tapY_ptr)*0.75f;
    
    GLfloat randomZ = (random()%100)*0.005 + 0.5; // 1.5 ~ 0.5
    GLfloat depthWeight = 2.0 - randomZ;
    
    TAPED_Center[TAP_INDEX][0] = tapX * depthWeight;
    TAPED_Center[TAP_INDEX][1] = tapY * depthWeight;
    TAPED_Center[TAP_INDEX][2] = randomZ;
    
    TAP_COUNTER[TAP_INDEX][0] = 0.0f;
    TAP_COUNTER[TAP_INDEX][1] = 0.0f;
    
    TAP_INDEX++;
    if( TAP_INDEX > M06_TAP_NUM )
    {
        TAP_INDEX = 0;
    }
}

- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM
{
    GLfloat LP_X = (*LPress_X_ptr);
    GLfloat LP_Y = (*LPress_Y_ptr)*0.75f;
}


- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM
{
    GLfloat* panPtr = Value_ptr;
    GLfloat posX = (*panPtr);
    panPtr++;
    GLfloat posY = (*panPtr)*0.75;
    panPtr++;
    GLfloat transX = *panPtr;
    panPtr++;
    GLfloat transY = *panPtr;
    panPtr++;
    GLfloat vecX = *panPtr;
    panPtr++;
    GLfloat vecY = *panPtr;
    panPtr++;
    GLfloat velocity = *panPtr;
 
}

- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM
{
    GLfloat* tempPtr = Center_ptr;
    GLfloat Pinch_X = (*tempPtr);   tempPtr++;
    GLfloat Pinch_Y = (*tempPtr)*0.75f;
    GLfloat Radius = (*Radius_ptr);
    GLfloat Scale = (*Scale_ptr);
    GLfloat Velocity = (*Vel_ptr);
}


- (void)stopLongPress:(Byte)index
{

}

- (void)stopPan
{

}

- (void)stopPinch
{

}

@end